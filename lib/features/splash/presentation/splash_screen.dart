import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/domain/auth_repository.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('SplashScreen initialized');  // Debug print
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    print('Starting auth check...');
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check onboarding status first
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (!mounted) return;

    if (!onboardingCompleted) {
      print('Navigating to onboarding');
      context.go('/onboarding');
      return;
    }

    // Then check auth status
    final user = ref.read(authRepositoryProvider).valueOrNull;
    print('Auth state: ${user != null ? 'User found' : 'No user'}');

    if (!mounted) return;

    if (user == null) {
      print('Navigating to auth screen');
      context.go('/auth');
    } else {
      print('Navigating to main screen');
      context.go('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building SplashScreen');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/gdglogo.png',
              height: 120,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading GDG logo: $error'); // More specific error message
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.image_not_supported,
                      size: 120,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Error: $error',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
  }