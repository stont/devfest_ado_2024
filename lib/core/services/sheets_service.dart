// lib/core/services/sheets_service.dart
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../config/api_config.dart';

part 'sheets_service.g.dart';

class GoogleSheetsException implements Exception {
  final String message;
  GoogleSheetsException(this.message);

  @override
  String toString() => 'GoogleSheetsException: $message';
}

@riverpod
class GoogleSheetsService extends _$GoogleSheetsService {
  static const _spreadsheetId = '1HGxJI85k-kV3dvODb3LKrpDd7583uJcuNqMLbxX7vEM';
  static const _range = 'Sessions!A2:I'; // Adjust based on your sheet structure

  Future<List<List<dynamic>>> fetchSessionData() async {
    try {
      final client = await _getClient();
      final sheetsApi = SheetsApi(client);

      final response = await sheetsApi.spreadsheets.values.get(
        _spreadsheetId,
        _range,
      );

      return response.values ?? [];
    } catch (e) {
      throw GoogleSheetsException('Failed to fetch session data: $e');
    }
  }

  Future<AuthClient?> _getClient() async {
    try {
      final client = http.Client();
      return clientViaApiKey(ApiConfig.googleApiKey);
    } catch (e) {
      throw GoogleSheetsException('Failed to authenticate with Google Sheets: $e');
    }
  }

  @override
  Future<List<List<dynamic>>> build() async {
    return fetchSessionData();
  }
}