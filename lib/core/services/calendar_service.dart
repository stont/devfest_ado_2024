// lib/core/services/calendar_service.dart
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/home/domain/models/session.dart';

class CalendarService {
  Future<bool> addToCalendar(Session session) async {
    final sessionType = SessionType.fromString(session.type);
    final Event event = Event(
      title: 'DevFest Ado 2024: ${session.title}',
      description: '''
🎯 Session: ${session.title}
👤 Speaker: ${session.speaker}
🏷️ Type: ${sessionType.label}
📍 Location: ${session.location ?? 'DevFest Ado 2024 Venue'}

${session.description ?? ''}

This session is part of DevFest Ado 2024. 
Join us for an amazing day of learning and networking!

#DevFestAdo2024
''',
      location: session.location ?? 'DevFest Ado 2024 Venue',
      startDate: session.startTime,
      endDate: session.endTime,
      androidParams: const AndroidParams(
        emailInvites: [],
        reminder: true,
        useDefaultReminder: true,
      ),
      iosParams: const IOSParams(
        reminder: Duration(hours: 1),
        url: 'devfestado2024://',
      ),
    );

    final result = await Add2Calendar.addEvent2Cal(event);
    if (result) {
      // Sync with calendar provider if needed
      await _syncWithCalendar(session);
    }
    return result;
  }

  Future<void> _syncWithCalendar(Session session) async {
    // TODO: Implement calendar sync
    // This could sync with Google Calendar or device calendar
  }

  Future<void> shareSession(Session session) async {
    final sessionType = SessionType.fromString(session.type);
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    final String shareText = '''
🎉 Join me at DevFest Ado 2024!

I'm attending "${session.title}" by ${session.speaker}

📅 ${dateFormat.format(session.startTime)}
⏰ ${timeFormat.format(session.startTime)} - ${timeFormat.format(session.endTime)}
🏷️ ${sessionType.label}
📍 ${session.location ?? 'DevFest Ado 2024 Venue'}

${session.description ?? ''}

Don't miss out on this amazing session and many more at DevFest Ado 2024! 

#DevFestAdo2024 #GDG #GoogleDevFest
''';

    await Share.share(shareText);
  }
}