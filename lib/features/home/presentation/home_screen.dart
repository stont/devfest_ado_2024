// lib/features/home/presentation/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devfest_ado_2024/features/auth/domain/auth_repository.dart';
import 'package:devfest_ado_2024/features/home/presentation/widgets/next_session_alert.dart';
import 'package:devfest_ado_2024/features/home/presentation/widgets/quick_actions.dart';
import 'package:devfest_ado_2024/features/home/presentation/widgets/upcoming_sessions.dart';
import 'package:devfest_ado_2024/features/home/presentation/widgets/twitter_feed.dart';

import '../domain/repositories/session_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'DevFest Ado 2024',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              ref.read(authRepositoryProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Only invalidate session repository since tweets are static for now
          ref.invalidate(sessionRepositoryProvider);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: NextSessionAlert(),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: QuickActions(),
            ),
            SizedBox(height: 24),
            UpcomingSessions(),
            SizedBox(height: 24),
            TwitterFeed(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}