// lib/features/home/domain/models/tweet.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tweet.freezed.dart';
part 'tweet.g.dart';

@freezed
class Tweet with _$Tweet {
  const factory Tweet({
    required String id,
    required String text,
    required DateTime createdAt,
    required String author,
    required String authorUsername,
    required String authorAvatar,
    @Default(0) int likeCount,
    @Default(0) int retweetCount,
    @Default(0) int replyCount,
  }) = _Tweet;

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);
}