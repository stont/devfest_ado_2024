// lib/features/home/data/services/calendar_service.dart
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/services/calendar_service.dart';
import '../../domain/models/session.dart';

part 'calendar_service.g.dart';

class CalendarService {
  Future<bool> addToCalendar(Session session) async {
    final Event event = Event(
      title: 'DevFest Ado 2024: ${session.title}',
      description: '''
${session.description ?? ''}

Speaker: ${session.speaker}
Type: ${session.type}
''',
      location: 'DevFest Ado 2024 Venue',
      startDate: session.startTime,
      endDate: session.endTime,
      androidParams: const AndroidParams(
        emailInvites: [], // Add email invites if needed
      ),
      iosParams: const IOSParams(
        reminder: Duration(hours: 1), // Reminder 1 hour before
      ),
    );

    return await Add2Calendar.addEvent2Cal(event);
  }

  Future<void> shareSession(Session session) async {
    final formattedStart = _formatDateTime(session.startTime);
    final formattedEnd = _formatDateTime(session.endTime);

    final String shareText = '''
🎯 DevFest Ado 2024 Session

${session.title}
👤 Speaker: ${session.speaker}
⏰ Time: $formattedStart - $formattedEnd
🏷️ Type: ${session.type}

${session.description ?? ''}

#DevFestAdo2024
''';

    await Share.share(shareText);
  }

  String _formatDateTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

@riverpod
CalendarService calendarService(CalendarServiceRef ref) {
  return CalendarService();
}