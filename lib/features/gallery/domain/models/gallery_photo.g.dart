// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GalleryPhotoImpl _$$GalleryPhotoImplFromJson(Map<String, dynamic> json) =>
    _$GalleryPhotoImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$GalleryPhotoImplToJson(_$GalleryPhotoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
      'description': instance.description,
    };
