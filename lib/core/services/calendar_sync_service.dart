// lib/core/services/calendar_sync_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/home/domain/models/session.dart';

class CalendarSyncService {
  static const String _syncedSessionsKey = 'synced_sessions';

  Future<void> syncSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    final syncedSessions = prefs.getStringList(_syncedSessionsKey) ?? [];

    if (!syncedSessions.contains(session.id)) {
      syncedSessions.add(session.id);
      await prefs.setStringList(_syncedSessionsKey, syncedSessions);
    }
  }

  Future<bool> isSessionSynced(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    final syncedSessions = prefs.getStringList(_syncedSessionsKey) ?? [];
    return syncedSessions.contains(session.id);
  }

  Future<void> unsyncSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    final syncedSessions = prefs.getStringList(_syncedSessionsKey) ?? [];

    syncedSessions.remove(session.id);
    await prefs.setStringList(_syncedSessionsKey, syncedSessions);
  }
}