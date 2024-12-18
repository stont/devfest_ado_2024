// lib/features/gallery/domain/services/camera_service.dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as path;

part 'camera_service.g.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo != null) {
      return await _uploadPhoto(File(photo.path));
    }
    return null;
  }

  Future<String> _uploadPhoto(File photo) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}${path.extension(photo.path)}';
    final ref = _storage.ref().child('gallery/$fileName');

    final uploadTask = ref.putFile(photo);
    final snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }
}

@riverpod
CameraService cameraService(CameraServiceRef ref) {
  return CameraService();
}