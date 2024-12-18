// lib/features/gallery/domain/models/gallery_photo.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'gallery_photo.freezed.dart';
part 'gallery_photo.g.dart';

@freezed
class GalleryPhoto with _$GalleryPhoto {
  const factory GalleryPhoto({
    required String id,
    required String url,
    required DateTime timestamp,
    required String userId,
    String? description,
  }) = _GalleryPhoto;

  factory GalleryPhoto.fromJson(Map<String, dynamic> json) =>
      _$GalleryPhotoFromJson(json);
}