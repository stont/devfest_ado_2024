// lib/features/home/domain/models/session.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    required String title,
    required String speaker,
    required DateTime startTime,
    required DateTime endTime,
    required String type,
    String? description,
    String? speakerImage,
    String? location,
    @Default(false) bool isFavorite,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}

enum SessionType {
  talk('Talk'),
  workshop('Workshop'),
  panel('Panel'),
  breakout('Breakout'),
  networking('Networking');

  final String label;
  const SessionType(this.label);
}