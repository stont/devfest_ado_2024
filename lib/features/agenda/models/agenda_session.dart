// lib/features/agenda/models/agenda_session.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_session.freezed.dart';
part 'agenda_session.g.dart';

@freezed
class AgendaSession with _$AgendaSession {
  const factory AgendaSession({
    required String id,
    required String title,
    required String speaker,
    required DateTime startTime,
    required DateTime endTime,
    required String type,
    String? description,
    String? speakerImage,
  }) = _AgendaSession;

  factory AgendaSession.fromJson(Map<String, dynamic> json) => _$AgendaSessionFromJson(json);
}