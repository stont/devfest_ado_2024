// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GalleryPhoto _$GalleryPhotoFromJson(Map<String, dynamic> json) {
  return _GalleryPhoto.fromJson(json);
}

/// @nodoc
mixin _$GalleryPhoto {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this GalleryPhoto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GalleryPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GalleryPhotoCopyWith<GalleryPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryPhotoCopyWith<$Res> {
  factory $GalleryPhotoCopyWith(
          GalleryPhoto value, $Res Function(GalleryPhoto) then) =
      _$GalleryPhotoCopyWithImpl<$Res, GalleryPhoto>;
  @useResult
  $Res call(
      {String id,
      String url,
      DateTime timestamp,
      String userId,
      String? description});
}

/// @nodoc
class _$GalleryPhotoCopyWithImpl<$Res, $Val extends GalleryPhoto>
    implements $GalleryPhotoCopyWith<$Res> {
  _$GalleryPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GalleryPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GalleryPhotoImplCopyWith<$Res>
    implements $GalleryPhotoCopyWith<$Res> {
  factory _$$GalleryPhotoImplCopyWith(
          _$GalleryPhotoImpl value, $Res Function(_$GalleryPhotoImpl) then) =
      __$$GalleryPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      DateTime timestamp,
      String userId,
      String? description});
}

/// @nodoc
class __$$GalleryPhotoImplCopyWithImpl<$Res>
    extends _$GalleryPhotoCopyWithImpl<$Res, _$GalleryPhotoImpl>
    implements _$$GalleryPhotoImplCopyWith<$Res> {
  __$$GalleryPhotoImplCopyWithImpl(
      _$GalleryPhotoImpl _value, $Res Function(_$GalleryPhotoImpl) _then)
      : super(_value, _then);

  /// Create a copy of GalleryPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? description = freezed,
  }) {
    return _then(_$GalleryPhotoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GalleryPhotoImpl implements _GalleryPhoto {
  const _$GalleryPhotoImpl(
      {required this.id,
      required this.url,
      required this.timestamp,
      required this.userId,
      this.description});

  factory _$GalleryPhotoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GalleryPhotoImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final DateTime timestamp;
  @override
  final String userId;
  @override
  final String? description;

  @override
  String toString() {
    return 'GalleryPhoto(id: $id, url: $url, timestamp: $timestamp, userId: $userId, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GalleryPhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, url, timestamp, userId, description);

  /// Create a copy of GalleryPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GalleryPhotoImplCopyWith<_$GalleryPhotoImpl> get copyWith =>
      __$$GalleryPhotoImplCopyWithImpl<_$GalleryPhotoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GalleryPhotoImplToJson(
      this,
    );
  }
}

abstract class _GalleryPhoto implements GalleryPhoto {
  const factory _GalleryPhoto(
      {required final String id,
      required final String url,
      required final DateTime timestamp,
      required final String userId,
      final String? description}) = _$GalleryPhotoImpl;

  factory _GalleryPhoto.fromJson(Map<String, dynamic> json) =
      _$GalleryPhotoImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  DateTime get timestamp;
  @override
  String get userId;
  @override
  String? get description;

  /// Create a copy of GalleryPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GalleryPhotoImplCopyWith<_$GalleryPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
