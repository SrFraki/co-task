// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shopListHash() => r'c60dfe828a3ab30ca07bcf061338282d13a9b5b4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ShopList extends BuildlessNotifier<ShopListState> {
  late final ShopListType type;

  ShopListState build(
    ShopListType type,
  );
}

/// See also [ShopList].
@ProviderFor(ShopList)
const shopListProvider = ShopListFamily();

/// See also [ShopList].
class ShopListFamily extends Family<ShopListState> {
  /// See also [ShopList].
  const ShopListFamily();

  /// See also [ShopList].
  ShopListProvider call(
    ShopListType type,
  ) {
    return ShopListProvider(
      type,
    );
  }

  @override
  ShopListProvider getProviderOverride(
    covariant ShopListProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'shopListProvider';
}

/// See also [ShopList].
class ShopListProvider extends NotifierProviderImpl<ShopList, ShopListState> {
  /// See also [ShopList].
  ShopListProvider(
    ShopListType type,
  ) : this._internal(
          () => ShopList()..type = type,
          from: shopListProvider,
          name: r'shopListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shopListHash,
          dependencies: ShopListFamily._dependencies,
          allTransitiveDependencies: ShopListFamily._allTransitiveDependencies,
          type: type,
        );

  ShopListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final ShopListType type;

  @override
  ShopListState runNotifierBuild(
    covariant ShopList notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(ShopList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShopListProvider._internal(
        () => create()..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  NotifierProviderElement<ShopList, ShopListState> createElement() {
    return _ShopListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShopListProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShopListRef on NotifierProviderRef<ShopListState> {
  /// The parameter `type` of this provider.
  ShopListType get type;
}

class _ShopListProviderElement
    extends NotifierProviderElement<ShopList, ShopListState> with ShopListRef {
  _ShopListProviderElement(super.provider);

  @override
  ShopListType get type => (origin as ShopListProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
