// lib/features/home/data/repositories/twitter_repository.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/tweet.dart';
import '../services/twitter_api_service.dart';
import '../models/tweet.dart';

part 'twitter_repository.g.dart';

class TwitterRepository {
  final TwitterApiService _apiService;

  TwitterRepository(this._apiService);

  Future<List<Tweet>> getLatestTweets() async {
    try {
      return await _apiService.getGdgAdoTweets();
    } catch (e) {
      // Return cached tweets if available, otherwise rethrow
      rethrow;
    }
  }
}

@riverpod
TwitterRepository twitterRepository(TwitterRepositoryRef ref) {
  return TwitterRepository(ref.watch(twitterApiServiceProvider));
}

@riverpod
Future<List<Tweet>> tweets(TweetsRef ref) {
  return ref.watch(twitterRepositoryProvider).getLatestTweets();
}