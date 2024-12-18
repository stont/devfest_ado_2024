// lib/features/agenda/presentation/agenda_screen.dart
import 'package:flutter/material.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: const Center(
        child: Text('Agenda Screen - Coming Soon'),
      ),
    );
  }
}