// lib/features/home/presentation/widgets/animated_countdown.dart
import 'package:flutter/material.dart';

class AnimatedCountdownUnit extends StatelessWidget {
  final String value;
  final String label;
  final bool shouldAnimate;

  const AnimatedCountdownUnit({
    super.key,
    required this.value,
    required this.label,
    this.shouldAnimate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.scale(
              scale: shouldAnimate ? value : 1.0,
              child: child,
            );
          },
          child: Text(
            this.value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}