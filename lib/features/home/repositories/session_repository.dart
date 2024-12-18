// lib/features/home/domain/repositories/session_repository.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/session.dart';
import '../models/session.dart';

part 'session_repository.g.dart';

abstract class BaseSessionRepository {
  Future<List<Session>> getUpcomingSessions();
  Future<Session?> getNextSession();
  Future<void> toggleFavorite(String sessionId);
}

class SessionRepository implements BaseSessionRepository {
  @override
  Future<List<Session>> getUpcomingSessions() async {
    // TODO: Implement with Google Sheets API
    return [];
  }

  @override
  Future<Session?> getNextSession() async {
    // TODO: Implement with Google Sheets API
    return null;
  }

  @override
  Future<void> toggleFavorite(String sessionId) async {
    // TODO: Implement with local storage
  }
}

@riverpod
SessionRepository sessionRepository(SessionRepositoryRef ref) {
  return SessionRepository();
}