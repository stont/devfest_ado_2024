
// lib/features/home/domain/providers/session_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../repositories/session_repository.dart';
import '../models/session.dart';
import '../repositories/session_repository.dart';

part 'session_providers.g.dart';

@riverpod
Future<Session?> nextSession(NextSessionRef ref) {
  return ref.watch(sessionRepositoryProvider).getNextSession();
}

@riverpod
Future<List<Session>> upcomingSessions(UpcomingSessionsRef ref) {
  return ref.watch(sessionRepositoryProvider).getUpcomingSessions();
}

@riverpod
class SessionNotifier extends _$SessionNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> toggleFavorite(String sessionId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(sessionRepositoryProvider).toggleFavorite(sessionId)
    );
  }
}