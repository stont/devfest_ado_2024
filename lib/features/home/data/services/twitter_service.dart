// lib/features/home/data/services/twitter_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/tweet.dart';

part 'twitter_service.g.dart';

class TwitterService {
  // For now, we'll use a sample feed since Twitter API v2 requires authentication
  Future<List<Tweet>> getLatestTweets() async {
    // Simulated tweets for GDG Ado Ekiti
    return [
      Tweet(
        id: '1',
        text: 'Join us for DevFest Ado 2024! 🎉 Experience amazing tech talks, workshops, and networking opportunities. #DevFestAdo2024',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        author: 'GDG Ado Ekiti',
        authorUsername: '@gdgadoekiti',
        authorAvatar: 'https://via.placeholder.com/50',
        likeCount: 45,
        retweetCount: 23,
      ),
      Tweet(
        id: '2',
        text: '🚀 Early bird tickets are now available for DevFest Ado 2024! Don\'t miss out on this amazing opportunity to learn and connect with fellow developers.',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        author: 'GDG Ado-Ekiti',
        authorUsername: '@gdgadoekiti',
        authorAvatar: 'https://via.placeholder.com/50',
        likeCount: 38,
        retweetCount: 15,
      ),
    ];
  }
}

@riverpod
TwitterService twitterService(TwitterServiceRef ref) {
  return TwitterService();
}