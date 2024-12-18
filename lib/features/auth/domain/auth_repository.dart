// lib/features/auth/domain/auth_repository.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/services.dart';

part 'auth_repository.g.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

@riverpod
class AuthRepository extends _$AuthRepository {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  @override
  Stream<User?> build() {
    print('Building AuthRepository stream');  // Debug print
    return _auth.authStateChanges().map((user) {
      print('Auth state changed: ${user != null ? 'User found' : 'No user'}');  // Debug print
      return user;
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      print('Starting Google Sign In process');  // Debug print
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('Sign in cancelled by user');  // Debug print
        throw AuthException('Sign in cancelled by user');
      }

      try {
        print('Getting Google auth credentials');  // Debug print
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        print('Signing in with Firebase');  // Debug print
        await _auth.signInWithCredential(credential);
        print('Successfully signed in with Google');  // Debug print
      } catch (e) {
        print('Error during Google authentication: $e');  // Debug print
        await _googleSignIn.signOut();
        rethrow;
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');  // Debug print
      throw AuthException(_getFirebaseAuthErrorMessage(e.code));
    } on PlatformException catch (e) {
      print('PlatformException: ${e.code}');  // Debug print
      throw AuthException(_getPlatformErrorMessage(e.code));
    } catch (e) {
      print('Unexpected error: $e');  // Debug print
      if (e is AuthException) rethrow;
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }

  Future<void> signOut() async {
    try {
      print('Starting sign out process');  // Debug print
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      print('Successfully signed out');  // Debug print
    } catch (e) {
      print('Error during sign out: $e');  // Debug print
      throw AuthException('Failed to sign out. Please try again.');
    }
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address.';
      case 'invalid-credential':
        return 'The credential is invalid or has expired.';
      case 'operation-not-allowed':
        return 'Google sign-in is not enabled for this project.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      default:
        return 'An error occurred during sign in. Please try again.';
    }
  }

  String _getPlatformErrorMessage(String code) {
    switch (code) {
      case 'sign_in_failed':
        return 'Google sign in failed. Please try again.';
      case 'network_error':
        return 'Network error occurred. Please check your connection.';
      default:
        return 'An error occurred during sign in. Please try again.';
    }
  }
}