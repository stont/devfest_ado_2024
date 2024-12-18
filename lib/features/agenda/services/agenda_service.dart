// lib/features/agenda/services/agenda_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/agenda_session.dart';
import 'package:intl/intl.dart';

part 'agenda_service.g.dart';

@riverpod
Future<List<AgendaSession>> agendaSessions(AgendaSessionsRef ref) async {
  final service = AgendaService();
  return service.fetchSessions();
}

class AgendaService {
  static const _spreadsheetId = '1HGxJI85k-kV3dvODb3LKrpDd7583uJcuNqMLbxX7vEM';
  static const _apiKey = 'AIzaSyBwZhhMfEah2f0pHigjpNdQ9NN5dMjrGW8';

  DateTime? _parseDate(String dateStr) {
    final formats = [
      'MM/dd/yyyy HH:mm',
      'M/d/yyyy HH:mm',
      'yyyy-MM-dd HH:mm',
      'dd/MM/yyyy HH:mm',
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parse(dateStr.trim());
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  Future<List<AgendaSession>> fetchSessions() async {
    final url = Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/Sessions!A2:I?key=$_apiKey'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Failed to load sessions: ${response.body}');
      }

      final data = json.decode(response.body);
      final List<List<dynamic>> values = List<List<dynamic>>.from(data['values']);
      final sessions = <AgendaSession>[];

      for (final row in values) {
        if (row.length < 5) continue;

        final startTime = _parseDate(row[3].toString());
        final endTime = _parseDate(row[4].toString());

        if (startTime == null || endTime == null) {
          print('Invalid date format in row: $row');
          continue;
        }

        sessions.add(AgendaSession(
          id: row[0].toString(),
          title: row[1].toString(),
          speaker: row[2].toString(),
          startTime: startTime,
          endTime: endTime,
          type: row[5].toString(),
          description: row.length > 6 ? row[6]?.toString() : null,
          speakerImage: row.length > 7 ? row[7]?.toString() : null,
        ));
      }

      return sessions;
    } catch (e) {
      print('Error fetching sessions: $e');
      throw Exception('Failed to load sessions: $e');
    }
  }
}