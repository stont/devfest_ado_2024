// lib/features/home/presentation/widgets/session_card.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/calendar_service.dart';
import '../../domain/models/session.dart';

class SessionCard extends StatelessWidget {
  final Session session;
  final CalendarService _calendarService = CalendarService();

  SessionCard({
    super.key,
    required this.session,
  });

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'workshop':
        return AppColors.googleBlue;
      case 'talk':
        return AppColors.googleGreen;
      case 'panel':
        return AppColors.googleYellow;
      case 'networking':
        return AppColors.googleRed;
      default:
        return AppColors.googleBlue;
    }
  }

  Future<void> _handleAddToCalendar(BuildContext context) async {
    try {
      final added = await _calendarService.addToCalendar(session);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              added ? 'Added to calendar' : 'Failed to add to calendar',
            ),
            backgroundColor: added ? AppColors.googleGreen : AppColors.googleRed,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to add to calendar'),
            backgroundColor: AppColors.googleRed,
          ),
        );
      }
    }
  }

  Future<void> _handleShare(BuildContext context) async {
    try {
      await _calendarService.shareSession(session);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to share session'),
            backgroundColor: AppColors.googleRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(session.type);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: typeColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: typeColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        session.speaker,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    session.type,
                    style: TextStyle(
                      color: typeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (session.description != null) ...[
              const SizedBox(height: 12),
              Text(
                session.description!,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handleAddToCalendar(context),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Add to Calendar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.googleBlue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _handleShare(context),
                  icon: const Icon(Icons.share),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.googleBlueLighter,
                    foregroundColor: AppColors.googleBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}