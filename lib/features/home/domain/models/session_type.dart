// lib/features/home/domain/models/session_type.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';

enum SessionType {
  keynote(
    label: 'Keynote',
    color: AppColors.googleBlue,
    icon: Icons.stars,
  ),
  workshop(
    label: 'Workshop',
    color: AppColors.googleGreen,
    icon: Icons.build,
  ),
  talk(
    label: 'Talk',
    color: AppColors.googleYellow,
    icon: Icons.mic,
  ),
  panel(
    label: 'Panel',
    color: AppColors.googleRed,
    icon: Icons.groups,
  ),
  codelab(
    label: 'Codelab',
    color: AppColors.googleBlue,
    icon: Icons.code,
  ),
  networking(
    label: 'Networking',
    color: AppColors.googleGreen,
    icon: Icons.people,
  ),
  breakout(
    label: 'Breakout',
    color: AppColors.googleYellow,
    icon: Icons.break_presentation,
  );

  final String label;
  final Color color;
  final IconData icon;

  const SessionType({
    required this.label,
    required this.color,
    required this.icon,
  });

  static SessionType fromString(String value) {
    return SessionType.values.firstWhere(
          (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => SessionType.talk,
    );
  }
}
