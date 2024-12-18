// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgendaSession _$AgendaSessionFromJson(Map<String, dynamic> json) {
  return _AgendaSession.fromJson(json);
}

/// @nodoc
mixin _$AgendaSession {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get speaker => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get speakerImage => throw _privateConstructorUsedError;

  /// Serializes this AgendaSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgendaSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgendaSessionCopyWith<AgendaSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgendaSessionCopyWith<$Res> {
  factory $AgendaSessionCopyWith(
          AgendaSession value, $Res Function(AgendaSession) then) =
      _$AgendaSessionCopyWithImpl<$Res, AgendaSession>;
  @useResult
  $Res call(
      {String id,
      String title,
      String speaker,
      DateTime startTime,
      DateTime endTime,
      String type,
      String? description,
      String? speakerImage});
}

/// @nodoc
class _$AgendaSessionCopyWithImpl<$Res, $Val extends AgendaSession>
    implements $AgendaSessionCopyWith<$Res> {
  _$AgendaSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgendaSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? speaker = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? type = null,
    Object? description = freezed,
    Object? speakerImage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      speakerImage: freezed == speakerImage
          ? _value.speakerImage
          : speakerImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgendaSessionImplCopyWith<$Res>
    implements $AgendaSessionCopyWith<$Res> {
  factory _$$AgendaSessionImplCopyWith(
          _$AgendaSessionImpl value, $Res Function(_$AgendaSessionImpl) then) =
      __$$AgendaSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String speaker,
      DateTime startTime,
      DateTime endTime,
      String type,
      String? description,
      String? speakerImage});
}

/// @nodoc
class __$$AgendaSessionImplCopyWithImpl<$Res>
    extends _$AgendaSessionCopyWithImpl<$Res, _$AgendaSessionImpl>
    implements _$$AgendaSessionImplCopyWith<$Res> {
  __$$AgendaSessionImplCopyWithImpl(
      _$AgendaSessionImpl _value, $Res Function(_$AgendaSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AgendaSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? speaker = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? type = null,
    Object? description = freezed,
    Object? speakerImage = freezed,
  }) {
    return _then(_$AgendaSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      speakerImage: freezed == speakerImage
          ? _value.speakerImage
          : speakerImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgendaSessionImpl implements _AgendaSession {
  const _$AgendaSessionImpl(
      {required this.id,
      required this.title,
      required this.speaker,
      required this.startTime,
      required this.endTime,
      required this.type,
      this.description,
      this.speakerImage});

  factory _$AgendaSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgendaSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String speaker;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String type;
  @override
  final String? description;
  @override
  final String? speakerImage;

  @override
  String toString() {
    return 'AgendaSession(id: $id, title: $title, speaker: $speaker, startTime: $startTime, endTime: $endTime, type: $type, description: $description, speakerImage: $speakerImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.speakerImage, speakerImage) ||
                other.speakerImage == speakerImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, speaker, startTime,
      endTime, type, description, speakerImage);

  /// Create a copy of AgendaSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgendaSessionImplCopyWith<_$AgendaSessionImpl> get copyWith =>
      __$$AgendaSessionImplCopyWithImpl<_$AgendaSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgendaSessionImplToJson(
      this,
    );
  }
}

abstract class _AgendaSession implements AgendaSession {
  const factory _AgendaSession(
      {required final String id,
      required final String title,
      required final String speaker,
      required final DateTime startTime,
      required final DateTime endTime,
      required final String type,
      final String? description,
      final String? speakerImage}) = _$AgendaSessionImpl;

  factory _AgendaSession.fromJson(Map<String, dynamic> json) =
      _$AgendaSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get speaker;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get type;
  @override
  String? get description;
  @override
  String? get speakerImage;

  /// Create a copy of AgendaSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgendaSessionImplCopyWith<_$AgendaSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
