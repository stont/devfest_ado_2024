// lib/features/home/domain/repositories/session_repository.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/session.dart';
import '../../../../core/services/google_sheets_service.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

part 'session_repository.g.dart';

@riverpod
class SessionRepository extends _$SessionRepository {
  static const String _cacheKey = 'cached_sessions';
  final _dateFormat = DateFormat('MM/dd/yyyy HH:mm');

  Future<List<Session>> _fetchSessions() async {
    try {
      // Try to fetch from Google Sheets
      final sessions = await _fetchFromSheets();
      // Cache the successful response
      await _cacheSessions(sessions);
      return sessions;
    } catch (e) {
      print('Error fetching sessions: $e');
      // On error, try to get cached data
      final cachedSessions = await _getCachedSessions();
      if (cachedSessions.isNotEmpty) {
        return cachedSessions;
      }
      // If no cached data, return fallback data
      return _getFallbackSessions();
    }
  }

  Future<List<Session>> _fetchFromSheets() async {
    final service = ref.read(googleSheetsServiceProvider);
    final sheetsData = await service.fetchSessionData();
    return _parseSessions(sheetsData);
  }

  List<Session> _parseSessions(List<List<String>> rows) {
    return rows.map((row) {
      try {
        return Session(
          id: row[0],
          title: row[1],
          speaker: row[2],
          startTime: _dateFormat.parse(row[3]),
          endTime: _dateFormat.parse(row[4]),
          type: row[5],
          description: row.length > 6 ? row[6] : null,
          speakerImage: row.length > 7 ? row[7] : null,
          location: row.length > 8 ? row[8] : null,
        );
      } catch (e) {
        print('Error parsing row: $row');
        print('Error details: $e');
        rethrow;
      }
    }).toList();
  }

  Future<void> _cacheSessions(List<Session> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = sessions.map((s) => s.toJson()).toList();
    await prefs.setString(_cacheKey, json.encode(sessionsJson));
  }

  Future<List<Session>> _getCachedSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cacheKey);
    if (cachedData != null) {
      try {
        final List<dynamic> sessionsJson = json.decode(cachedData);
        return sessionsJson
            .map((json) => Session.fromJson(json as Map<String, dynamic>))
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  List<Session> _getFallbackSessions() {
    final now = DateTime.now();
    return [
      Session(
        id: '1',
        title: 'Flutter Workshop',
        speaker: 'John Doe',
        startTime: now.add(const Duration(hours: 1)),
        endTime: now.add(const Duration(hours: 3)),
        type: 'Workshop',
        description: 'Learn Flutter basics and build your first app',
        location: 'Main Hall',
      ),
      Session(
        id: '2',
        title: 'Firebase Integration',
        speaker: 'Jane Smith',
        startTime: now.add(const Duration(hours: 4)),
        endTime: now.add(const Duration(hours: 6)),
        type: 'Talk',
        description: 'Integrate Firebase with your Flutter app',
        location: 'Room A',
      ),
    ];
  }

  @override
  Future<List<Session>> build() async {
    return _fetchSessions();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchSessions);
  }

  Session? getNextSession() {
    if (!state.hasValue) return null;

    final sessions = state.value!;
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

  List<Session> getUpcomingSessions() {
    if (!state.hasValue) return [];

    final sessions = state.value!;
    final now = DateTime.now();
    return sessions
        .where((session) => session.startTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }
}