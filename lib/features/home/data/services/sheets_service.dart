// lib/features/home/data/services/sheets_service.dart
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/session.dart';

part 'sheets_service.g.dart';

class SheetsService {
  static const _spreadsheetId = '1HGxJI85k-kV3dvODb3LKrpDd7583uJcuNqMLbxX7vEM';
  static const _apiKey = 'AIzaSyA3lmWX2XIrzkn7uhKQmQvQMuU1-O26hKY'; // Replace with your API key

  Future<List<Session>> fetchSessions() async {
    final client = http.Client();
    try {
      final api = SheetsApi(await clientViaApiKey(_apiKey));

      final response = await api.spreadsheets.values.get(
        _spreadsheetId,
        'Sessions!A2:F2',
      );

      final rows = response.values ?? [];
      return _parseSessions(rows);
    } finally {
      client.close();
    }
  }

  List<Session> _parseSessions(List<List<dynamic>> rows) {
    return rows.map((row) {
      return Session(
        id: row[0].toString(),
        title: row[1].toString(),
        speaker: row[2].toString(),
        startTime: DateTime.parse(row[3].toString()),
        endTime: DateTime.parse(row[4].toString()),
        type: row[5].toString(),
        description: row[6].toString(),
        speakerImage: row.length > 7 ? row[7].toString() : null,
      );
    }).toList();
  }
}

@riverpod
SheetsService sheetsService(SheetsServiceRef ref) {
  return SheetsService();
}