// lib/features/home/domain/repositories/sessions_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/session.dart';
import '../providers/session_providers.dart';
import 'session_repository.dart';

part 'sessions_provider.g.dart';

@riverpod
Future<Session?> nextSession(NextSessionRef ref) async {
  final sessions = await ref.watch(sessionRepositoryProvider.future);
  final now = DateTime.now();
  try {
    return sessions
        .where((session) => session.startTime.isAfter(now))
        .reduce((curr, next) =>
    curr.startTime.isBefore(next.startTime) ? curr : next);
  } catch (e) {
    return null;
  }
}

@riverpod
Future<List<Session>> upcomingSessions(UpcomingSessionsRef ref) async {
  final sessions = await ref.watch(sessionRepositoryProvider.future);
  final now = DateTime.now();
  return sessions
      .where((session) => session.startTime.isAfter(now))
      .toList()
    ..sort((a, b) => a.startTime.compareTo(b.startTime));
}