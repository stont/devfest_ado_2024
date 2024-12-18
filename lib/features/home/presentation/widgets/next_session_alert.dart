// lib/features/home/presentation/widgets/next_session_alert.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/agenda/services/agenda_service.dart';
import '../../../../features/agenda/models/agenda_session.dart';
import 'package:intl/intl.dart';

class NextSessionAlert extends ConsumerWidget {
  const NextSessionAlert({super.key});

  AgendaSession? _getNextSession(List<AgendaSession> sessions) {
    final now = DateTime.now();
    try {
      return sessions
          .where((session) => session.startTime.isAfter(now))
          .reduce((a, b) => a.startTime.isBefore(b.startTime) ? a : b);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(agendaSessionsProvider);

    return sessionsAsync.when(
      data: (sessions) {
        final nextSession = _getNextSession(sessions);
        if (nextSession == null) return const SizedBox.shrink();

        return _buildNextSessionCard(context, nextSession);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildNextSessionCard(BuildContext context, AgendaSession session) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Next Session',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              session.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            _buildSpeakerRow(session),
            const SizedBox(height: 16),
            _buildTimeRow(session),
            if (session.description != null) ...[
              const SizedBox(height: 12),
              _buildDescription(session.description!),
            ],
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakerRow(AgendaSession session) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundImage: session.speakerImage != null
              ? NetworkImage(session.speakerImage!)
              : null,
          child: session.speakerImage == null
              ? const Icon(Icons.person, size: 18, color: Colors.white)
              : null,
        ),
        const SizedBox(width: 8),
        Text(
          session.speaker,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        _buildTypeChip(session.type),
      ],
    );
  }

  Widget _buildTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTimeRow(AgendaSession session) {
    final timeFormat = DateFormat('hh:mm a');
    return Row(
      children: [
        Icon(Icons.access_time,
            size: 16, color: Colors.white.withOpacity(0.7)),
        const SizedBox(width: 4),
        Text(
          '${timeFormat.format(session.startTime)} - ${timeFormat.format(session.endTime)}',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(
        color: Colors.white.withOpacity(0.7),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement calendar integration
            },
            icon: const Icon(Icons.calendar_today),
            label: const Text('Add to Calendar'),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            // TODO: Implement share functionality
          },
          icon: const Icon(Icons.share),
          style: IconButton.styleFrom(
            backgroundColor: Colors.blue.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}