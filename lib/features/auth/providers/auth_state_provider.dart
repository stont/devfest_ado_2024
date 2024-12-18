// lib/features/auth/providers/auth_state_provider.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final authStateProvider = StreamProvider<User?>((ref) {
return FirebaseAuth.instance.authStateChanges();
});
