// lib/core/services/google_sheets_service.dart
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/googleapis_auth.dart' show clientViaApiKey;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../config/api_config.dart';

part 'google_sheets_service.g.dart';

class GoogleSheetsException implements Exception {
  final String message;
  GoogleSheetsException(this.message);

  @override
  String toString() => 'GoogleSheetsException: $message';
}

class GoogleSheetsService {
  static const _spreadsheetId = '1HGxJI85k-kV3dvODb3LKrpDd7583uJcuNqMLbxX7vEM';
  static const _range = 'Sessions!A2:I'; // Adjust based on your sheet structure

  Future<List<List<String>>> fetchSessionData() async {
    try {
      final client = await clientViaApiKey(ApiConfig.googleApiKey);
      final sheetsApi = sheets.SheetsApi(client);

      final response = await sheetsApi.spreadsheets.values.get(
        _spreadsheetId,
        _range,
      );

      if (response.values == null) {
        throw GoogleSheetsException('No data found in sheet');
      }

      return response.values!.map((row) {
        return row.map((cell) => cell.toString()).toList();
      }).toList();
    } catch (e) {
      throw GoogleSheetsException('Failed to fetch session data: $e');
    }
  }
}

@riverpod
GoogleSheetsService googleSheetsService(GoogleSheetsServiceRef ref) {
  return GoogleSheetsService();
}