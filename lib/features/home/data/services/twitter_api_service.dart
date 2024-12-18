// lib/features/home/data/services/twitter_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/config/api_config.dart';
import '../../domain/models/tweet.dart';

part 'twitter_api_service.g.dart';

@riverpod
class TwitterApi extends _$TwitterApi {
  static const String _cacheKey = 'cached_tweets';

  // Mock data for fallback
  final List<Tweet> _fallbackTweets = [
    Tweet(
      id: '1',
      text: '🎉 Mark your calendars for DevFest Ado 2024! Join us for an incredible day of learning, networking, and fun. Early bird tickets available now! #DevFestAdo2024',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      author: 'GDG Ado Ekiti',
      authorUsername: 'gdgadoekiti',
      authorAvatar: 'https://pbs.twimg.com/profile_images/1580797941721178112/CfXqKGKx_400x400.jpg',
      likeCount: 45,
      retweetCount: 23,
      replyCount: 5,
    ),
    Tweet(
      id: '2',
      text: '📢 Call for Speakers is now open! Share your knowledge and experience at DevFest Ado 2024. Submit your proposals today! Topics: Web, Mobile, Cloud, AI/ML, and more. #TechCommunity',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      author: 'GDG Ado Ekiti',
      authorUsername: 'gdgadoekiti',
      authorAvatar: 'https://pbs.twimg.com/profile_images/1580797941721178112/CfXqKGKx_400x400.jpg',
      likeCount: 38,
      retweetCount: 15,
      replyCount: 3,
    ),
    Tweet(
      id: '3',
      text: '💻 Exciting workshops lined up for DevFest Ado 2024:\n• Flutter Development\n• Cloud Computing\n• Machine Learning\n• Web Development\nStay tuned for more updates! #DevFestAdo2024',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      author: 'GDG Ado Ekiti',
      authorUsername: 'gdgadoekiti',
      authorAvatar: 'https://pbs.twimg.com/profile_images/1580797941721178112/CfXqKGKx_400x400.jpg',
      likeCount: 52,
      retweetCount: 28,
      replyCount: 7,
    ),
    Tweet(
      id: '4',
      text: '🤝 Interested in sponsoring DevFest Ado 2024? We have various sponsorship packages available. Reach out to us for more information! #TechSponsorship #DevFest2024',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      author: 'GDG Ado Ekiti',
      authorUsername: 'gdgadoekiti',
      authorAvatar: 'https://pbs.twimg.com/profile_images/1580797941721178112/CfXqKGKx_400x400.jpg',
      likeCount: 35,
      retweetCount: 18,
      replyCount: 4,
    ),
    Tweet(
      id: '5',
      text: '🌟 Previous DevFest Highlights:\n• 500+ Attendees\n• 20+ Speakers\n• Hands-on Workshops\n• Networking Sessions\n\nDevFest Ado 2024 will be even bigger! Don\'t miss out! #DevFestMemories',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      author: 'GDG Ado Ekiti',
      authorUsername: 'gdgadoekiti',
      authorAvatar: 'https://pbs.twimg.com/profile_images/1580797941721178112/CfXqKGKx_400x400.jpg',
      likeCount: 42,
      retweetCount: 20,
      replyCount: 6,
    ),
  ];

  Future<List<Tweet>> _fetchTweets() async {
    try {
      // Try to fetch from API
      final tweets = await _fetchFromApi();
      // Cache the successful response
      await _cacheTweets(tweets);
      return tweets;
    } catch (e) {
      // On error, try to get cached data
      final cachedTweets = await _getCachedTweets();
      if (cachedTweets.isNotEmpty) {
        return cachedTweets;
      }
      // If no cached data, return fallback data
      return _fallbackTweets;
    }
  }

  Future<List<Tweet>> _fetchFromApi() async {
    final url = Uri.parse(
        '${ApiConfig.twitterApiBaseUrl}/users/${ApiConfig.gdgAdoTwitterId}/tweets'
            '?max_results=10'
            '&tweet.fields=created_at,public_metrics'
            '&expansions=author_id'
            '&user.fields=name,username,profile_image_url'
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${ApiConfig.twitterBearerToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return _parseTweetsResponse(json.decode(response.body));
    } else {
      throw TwitterApiException(
        'Failed to fetch tweets',
        response.statusCode,
      );
    }
  }

  Future<void> _cacheTweets(List<Tweet> tweets) async {
    final prefs = await SharedPreferences.getInstance();
    final tweetsJson = tweets.map((t) => t.toJson()).toList();
    await prefs.setString(_cacheKey, json.encode(tweetsJson));
  }

  Future<List<Tweet>> _getCachedTweets() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cacheKey);
    if (cachedData != null) {
      try {
        final List<dynamic> tweetsJson = json.decode(cachedData);
        return tweetsJson
            .map((json) => Tweet.fromJson(json as Map<String, dynamic>))
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  List<Tweet> _parseTweetsResponse(Map<String, dynamic> data) {
    final List<dynamic> tweets = data['data'];
    final includes = data['includes'] as Map<String, dynamic>;
    final List<dynamic> users = includes['users'];
    final user = users.first;

    return tweets.map((tweetData) {
      final metrics = tweetData['public_metrics'] as Map<String, dynamic>;

      return Tweet(
        id: tweetData['id'],
        text: tweetData['text'],
        createdAt: DateTime.parse(tweetData['created_at']),
        author: user['name'],
        authorUsername: user['username'],
        authorAvatar: user['profile_image_url'],
        likeCount: metrics['like_count'] ?? 0,
        retweetCount: metrics['retweet_count'] ?? 0,
        replyCount: metrics['reply_count'] ?? 0,
      );
    }).toList();
  }

  @override
  Future<List<Tweet>> build() async {
    return _fetchTweets();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchTweets);
  }
}

class TwitterApiException implements Exception {
  final String message;
  final int? statusCode;

  TwitterApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'TwitterApiException: $message${statusCode != null ? ' (Status Code: $statusCode)' : ''}';
}