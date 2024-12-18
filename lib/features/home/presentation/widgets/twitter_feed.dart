// lib/features/home/presentation/widgets/twitter_feed.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devfest_ado_2024/features/home/data/services/twitter_api_service.dart';
import 'package:devfest_ado_2024/features/home/presentation/widgets/twitter_error_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../domain/models/tweet.dart';

class TwitterFeed extends ConsumerWidget {
  const TwitterFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetsAsync = ref.watch(twitterApiProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Latest Updates',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.blue),
                onPressed: () {
                  ref.read(twitterApiProvider.notifier).refresh();
                },
              ),
            ],
          ),
        ),
        tweetsAsync.when(
          data: (tweets) {
            if (tweets.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No updates available',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tweets.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white12,
                height: 1,
              ),
              itemBuilder: (context, index) => TweetCard(tweet: tweets[index]),
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) => TwitterErrorView(
            errorMessage: 'Failed to load updates: ${error.toString()}',
            onRetry: () => ref.read(twitterApiProvider.notifier).refresh(),
          ),
        ),
      ],
    );
  }
}

class TweetCard extends StatelessWidget {
  final Tweet tweet;

  const TweetCard({
    super.key,
    required this.tweet,
  });

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return DateFormat('MMM d').format(timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: tweet.authorAvatar,
              width: 40,
              height: 40,
              placeholder: (context, url) => Container(
                color: Colors.grey[800],
                child: const Icon(Icons.person, color: Colors.white70),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[800],
                child: const Icon(Icons.error, color: Colors.white70),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      tweet.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '@${tweet.authorUsername}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      ' • ${_getTimeAgo(tweet.createdAt)}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tweet.text,
                  style: const TextStyle(
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _TweetStat(
                      icon: Icons.favorite_border,
                      count: tweet.likeCount,
                    ),
                    const SizedBox(width: 24),
                    _TweetStat(
                      icon: Icons.repeat,
                      count: tweet.retweetCount,
                    ),
                    const SizedBox(width: 24),
                    _TweetStat(
                      icon: Icons.chat_bubble_outline,
                      count: tweet.replyCount,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TweetStat extends StatelessWidget {
  final IconData icon;
  final int count;

  const _TweetStat({
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}