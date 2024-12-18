// lib/features/gallery/models/gallery_photo.dart
class GalleryPhoto {
  final String id;
  final String url;
  final DateTime timestamp;
  final String userId;

  const GalleryPhoto({
    required this.id,
    required this.url,
    required this.timestamp,
    required this.userId,
  });
}