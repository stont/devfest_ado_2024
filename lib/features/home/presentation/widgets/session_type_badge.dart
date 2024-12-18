// lib/features/home/presentation/widgets/session_type_badge.dart
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../domain/models/session.dart';

class SessionTypeBadge extends StatelessWidget {
  final String type;

  const SessionTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final sessionType = SessionType.fromString(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: sessionType.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            sessionType.icon,
            size: 16,
            color: sessionType.color,
          ),
          const SizedBox(width: 4),
          Text(
            sessionType.label,
            style: TextStyle(
              color: sessionType.color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}