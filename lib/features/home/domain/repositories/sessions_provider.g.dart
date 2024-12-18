// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nextSessionHash() => r'0ceb460e5e31859c64e0bb59d3e856604a1d671f';

/// See also [nextSession].
@ProviderFor(nextSession)
final nextSessionProvider = AutoDisposeFutureProvider<Session?>.internal(
  nextSession,
  name: r'nextSessionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nextSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NextSessionRef = AutoDisposeFutureProviderRef<Session?>;
String _$upcomingSessionsHash() => r'eb0994e42908bdbbd1e269ffc03b42a0e2b6f11b';

/// See also [upcomingSessions].
@ProviderFor(upcomingSessions)
final upcomingSessionsProvider =
    AutoDisposeFutureProvider<List<Session>>.internal(
  upcomingSessions,
  name: r'upcomingSessionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingSessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingSessionsRef = AutoDisposeFutureProviderRef<List<Session>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
