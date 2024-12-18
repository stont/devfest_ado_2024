// lib/features/home/presentation/widgets/upcoming_sessions.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/agenda/services/agenda_service.dart';
import '../../../../features/agenda/models/agenda_session.dart';
import 'package:intl/intl.dart';

class UpcomingSessions extends ConsumerWidget {
  const UpcomingSessions({super.key});

  List<AgendaSession> _getUpcomingSessions(List<AgendaSession> sessions) {
    final now = DateTime.now();
    return sessions
        .where((session) => session.startTime.isAfter(now))
        .take(5)
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(agendaSessionsProvider);

    return sessionsAsync.when(
      data: (sessions) {
        final upcomingSessions = _getUpcomingSessions(sessions);
        if (upcomingSessions.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Upcoming Sessions',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingSessions.length,
              itemBuilder: (context, index) => _SessionCard(
                session: upcomingSessions[index],
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final AgendaSession session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('hh:mm a');

    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: session.speakerImage != null
              ? NetworkImage(session.speakerImage!)
              : null,
          child: session.speakerImage == null
              ? const Icon(Icons.person, color: Colors.white)
              : null,
        ),
        title: Text(
          session.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '${session.speaker} • ${timeFormat.format(session.startTime)}',
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            session.type,
            style: const TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
      ),
    );
  }
}