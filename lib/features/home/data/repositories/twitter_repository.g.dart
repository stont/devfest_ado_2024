// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitter_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$twitterRepositoryHash() => r'3335732a0013d4fad8970a3d84124ed7f6f95320';

/// See also [twitterRepository].
@ProviderFor(twitterRepository)
final twitterRepositoryProvider =
    AutoDisposeProvider<TwitterRepository>.internal(
  twitterRepository,
  name: r'twitterRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$twitterRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TwitterRepositoryRef = AutoDisposeProviderRef<TwitterRepository>;
String _$tweetsHash() => r'99b32bec5883b1f814d0bc69e9de00dc0827d1e2';

/// See also [tweets].
@ProviderFor(tweets)
final tweetsProvider = AutoDisposeFutureProvider<List<Tweet>>.internal(
  tweets,
  name: r'tweetsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tweetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TweetsRef = AutoDisposeFutureProviderRef<List<Tweet>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
