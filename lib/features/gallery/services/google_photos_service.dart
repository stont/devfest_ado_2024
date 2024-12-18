// lib/features/gallery/services/google_photos_service.dart
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class GooglePhotosService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1040104282952-a2vr477m706hfhr8uqiggt13rmvq882l.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/photoslibrary',
      'https://www.googleapis.com/auth/photoslibrary.sharing',
      'https://www.googleapis.com/auth/photoslibrary.appendonly'
    ],
  );

  static const String _albumId = 'a3cmGi3dDry9Jbtn6'; // Your album ID

  Future<void> uploadPhoto(File photoFile) async {
    try {
      // Force a new sign in to ensure fresh tokens
      await _googleSignIn.signOut();
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        throw Exception('Google Sign in failed - no account returned');
      }

      print('Signed in as: ${account.email}');

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? token = auth.accessToken;

      if (token == null) {
        throw Exception('No access token received');
      }

      print('Got access token, starting upload...');

      // First upload the binary
      final String uploadToken = await _uploadPhotoBinary(photoFile, token);
      print('Binary upload successful, got upload token: ${uploadToken.substring(0, 10)}...');

      // Then create the media item
      await _createMediaItem(uploadToken, token);
      print('Media item created successfully');

    } catch (e, stackTrace) {
      print('Error in uploadPhoto: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<String> _uploadPhotoBinary(File photo, String token) async {
    final bytes = await photo.readAsBytes();
    final uri = Uri.parse('https://photoslibrary.googleapis.com/v1/uploads');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/octet-stream',
          'X-Goog-Upload-Protocol': 'raw',
          'X-Goog-Upload-Content-Type': 'image/jpeg',
        },
        body: bytes,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        print('Upload binary failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to upload photo binary: ${response.statusCode}');
      }

      return response.body;
    } catch (e) {
      print('Error in _uploadPhotoBinary: $e');
      rethrow;
    }
  }

  Future<void> _createMediaItem(String uploadToken, String token) async {
    final uri = Uri.parse('https://photoslibrary.googleapis.com/v1/mediaItems:batchCreate');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'albumId': _albumId,
          'newMediaItems': [
            {
              'description': 'Uploaded from DevFest App',
              'simpleMediaItem': {
                'uploadToken': uploadToken,
                'fileName': 'DevFest_${DateTime.now().millisecondsSinceEpoch}.jpg'
              }
            }
          ]
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        print('Create media item failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create media item: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      print('Create media item response: $responseData');

    } catch (e) {
      print('Error in _createMediaItem: $e');
      rethrow;
    }
  }
}