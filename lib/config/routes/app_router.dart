// lib/config/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: RouterNotifier(ref),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainScreen(),
      ),
    ],
    redirect: (context, state) async {
      // Don't redirect on splash screen
      if (state.matchedLocation == '/') return null;

      // Get onboarding status
      final prefs = await SharedPreferences.getInstance();
      final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

      // Check authentication status
      final isAuth = authState.valueOrNull != null;

      // Current location checks
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isAuthRoute = state.matchedLocation == '/auth';
      final isMainRoute = state.matchedLocation == '/main';

      // Handle onboarding first
      if (!onboardingCompleted) {
        return isOnboarding ? null : '/onboarding';
      }

      // Then handle authentication
      if (!isAuth) {
        return isAuthRoute ? null : '/auth';
      }

      // If authenticated and onboarding is completed
      if (isAuth && onboardingCompleted) {
        return isMainRoute ? null : '/main';
      }

      return null;
    },
  );
}

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref) {
    ref.listen(authRepositoryProvider, (_, __) {
      notifyListeners();
    });
  }

  final Ref ref;
}