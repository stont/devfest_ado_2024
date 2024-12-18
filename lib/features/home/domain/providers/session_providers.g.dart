// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nextSessionHash() => r'5990e51d544465194a055e333949801de6fee9e9';

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
String _$upcomingSessionsHash() => r'532d7ec9fe3f97514dc0e2cb1704c013c3e5cf26';

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
String _$sessionNotifierHash() => r'1984b5c3d005d69db76dd26b3a3c3ebf3d467eaa';

/// See also [SessionNotifier].
@ProviderFor(SessionNotifier)
final sessionNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SessionNotifier, void>.internal(
  SessionNotifier.new,
  name: r'sessionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
