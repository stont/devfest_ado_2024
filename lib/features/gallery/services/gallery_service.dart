// lib/features/gallery/services/photos_service.dart
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photos_service.g.dart';

@riverpod
class PhotosService extends _$PhotosService {
  final _picker = ImagePicker();
  final String albumId = 'a3cmGi3dDry9Jbtn6'; // Replace with actual album ID

  Future<XFile?> takePhoto() async {
    return await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
  }

  Future<void> uploadToGooglePhotos(File photo) async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/photoslibrary',
        'https://www.googleapis.com/auth/photoslibrary.sharing',
      ],
      signInOption: SignInOption.standard,
    );

    try {
      final account = await googleSignIn.signIn();
      if (account == null) return;

      final auth = await account.authentication;
      final token = auth.accessToken;

      // Upload photo binary
      final uploadToken = await _uploadPhotoBinary(photo, token!);

      // Create media item in album
      await _createMediaItem(uploadToken, token);
    } catch (e) {
      throw Exception('Failed to upload photo: $e');
    }
  }

  Future<String> _uploadPhotoBinary(File photo, String token) async {
    final url = Uri.parse('https://photoslibrary.googleapis.com/v1/uploads');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/octet-stream',
        'X-Goog-Upload-Protocol': 'raw',
      },
      body: await photo.readAsBytes(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to upload photo binary');
    }

    return response.body;
  }

  Future<void> _createMediaItem(String uploadToken, String token) async {
    final url = Uri.parse('https://photoslibrary.googleapis.com/v1/mediaItems:batchCreate');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: '''
      {
        "albumId": "$albumId",
        "newMediaItems": [
          {
            "simpleMediaItem": {
              "uploadToken": "$uploadToken"
            }
          }
        ]
      }
      ''',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create media item');
    }
  }

  @override
  Stream<List<String>> build() {
    // Implement album photo fetching here
    return Stream.value([]);
  }
}