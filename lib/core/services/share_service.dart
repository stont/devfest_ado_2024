// lib/core/services/share_service.dart
import 'package:share_plus/share_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'share_service.g.dart';

class ShareService {
  Future<void> shareApp() async {
    await Share.share(
      'Check out DevFest Ado-Ekiti 2024!\n'
          'Download the app to access event information, take notes, share photos, and more!\n'
          'https://play.google.com/store/apps/details?id=com.gdgado.devfest2024', // Replace with actual app link
      subject: 'DevFest Ado-Ekiti 2024 App',
    );
  }

  Future<void> shareNote(String title, String content) async {
    await Share.share(
      'Note: $title\n\n$content\n\nShared from DevFest Ado-Ekiti 2024 App',
      subject: title,
    );
  }

  Future<void> sharePhoto(String photoUrl) async {
    await Share.share(
      'Check out this photo from DevFest Ado-Ekiti 2024!\n$photoUrl',
      subject: 'DevFest Ado-Ekiti 2024 Photo',
    );
  }
}

@riverpod
ShareService shareService(ShareServiceRef ref) {
  return ShareService();
}