// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'composite_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompositeItem _$CompositeItemFromJson(Map<String, dynamic> json) {
  return _CompositeItem.fromJson(json);
}

/// @nodoc
mixin _$CompositeItem {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get sellingPrice => throw _privateConstructorUsedError;
  double? get costPrice => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get autoAssemble => throw _privateConstructorUsedError;
  bool get canBeSoldSeparately => throw _privateConstructorUsedError;
  AssemblyType get assemblyType => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<CompositeItemComponent> get components =>
      throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get sku => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  double get assemblyTime => throw _privateConstructorUsedError; // in minutes
  String? get assemblyInstructions => throw _privateConstructorUsedError;
  bool get trackInventory => throw _privateConstructorUsedError;
  double get currentStock => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  double get minStock => throw _privateConstructorUsedError;
  double? get maxStock => throw _privateConstructorUsedError;

  /// Serializes this CompositeItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompositeItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompositeItemCopyWith<CompositeItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompositeItemCopyWith<$Res> {
  factory $CompositeItemCopyWith(
          CompositeItem value, $Res Function(CompositeItem) then) =
      _$CompositeItemCopyWithImpl<$Res, CompositeItem>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String code,
      String? description,
      double sellingPrice,
      double? costPrice,
      bool isActive,
      bool autoAssemble,
      bool canBeSoldSeparately,
      AssemblyType assemblyType,
      DateTime createdAt,
      DateTime updatedAt,
      List<CompositeItemComponent> components,
      DateTime? syncedAt,
      String? sku,
      String? barcode,
      String? categoryId,
      double taxRate,
      String? imageUrl,
      Map<String, dynamic> metadata,
      double assemblyTime,
      String? assemblyInstructions,
      bool trackInventory,
      double currentStock,
      String? unit,
      double minStock,
      double? maxStock});
}

/// @nodoc
class _$CompositeItemCopyWithImpl<$Res, $Val extends CompositeItem>
    implements $CompositeItemCopyWith<$Res> {
  _$CompositeItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompositeItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = null,
    Object? description = freezed,
    Object? sellingPrice = null,
    Object? costPrice = freezed,
    Object? isActive = null,
    Object? autoAssemble = null,
    Object? canBeSoldSeparately = null,
    Object? assemblyType = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? components = null,
    Object? syncedAt = freezed,
    Object? sku = freezed,
    Object? barcode = freezed,
    Object? categoryId = freezed,
    Object? taxRate = null,
    Object? imageUrl = freezed,
    Object? metadata = null,
    Object? assemblyTime = null,
    Object? assemblyInstructions = freezed,
    Object? trackInventory = null,
    Object? currentStock = null,
    Object? unit = freezed,
    Object? minStock = null,
    Object? maxStock = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      autoAssemble: null == autoAssemble
          ? _value.autoAssemble
          : autoAssemble // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeSoldSeparately: null == canBeSoldSeparately
          ? _value.canBeSoldSeparately
          : canBeSoldSeparately // ignore: cast_nullable_to_non_nullable
              as bool,
      assemblyType: null == assemblyType
          ? _value.assemblyType
          : assemblyType // ignore: cast_nullable_to_non_nullable
              as AssemblyType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      components: null == components
          ? _value.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<CompositeItemComponent>,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sku: freezed == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      assemblyTime: null == assemblyTime
          ? _value.assemblyTime
          : assemblyTime // ignore: cast_nullable_to_non_nullable
              as double,
      assemblyInstructions: freezed == assemblyInstructions
          ? _value.assemblyInstructions
          : assemblyInstructions // ignore: cast_nullable_to_non_nullable
              as String?,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      minStock: null == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompositeItemImplCopyWith<$Res>
    implements $CompositeItemCopyWith<$Res> {
  factory _$$CompositeItemImplCopyWith(
          _$CompositeItemImpl value, $Res Function(_$CompositeItemImpl) then) =
      __$$CompositeItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String code,
      String? description,
      double sellingPrice,
      double? costPrice,
      bool isActive,
      bool autoAssemble,
      bool canBeSoldSeparately,
      AssemblyType assemblyType,
      DateTime createdAt,
      DateTime updatedAt,
      List<CompositeItemComponent> components,
      DateTime? syncedAt,
      String? sku,
      String? barcode,
      String? categoryId,
      double taxRate,
      String? imageUrl,
      Map<String, dynamic> metadata,
      double assemblyTime,
      String? assemblyInstructions,
      bool trackInventory,
      double currentStock,
      String? unit,
      double minStock,
      double? maxStock});
}

/// @nodoc
class __$$CompositeItemImplCopyWithImpl<$Res>
    extends _$CompositeItemCopyWithImpl<$Res, _$CompositeItemImpl>
    implements _$$CompositeItemImplCopyWith<$Res> {
  __$$CompositeItemImplCopyWithImpl(
      _$CompositeItemImpl _value, $Res Function(_$CompositeItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompositeItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = null,
    Object? description = freezed,
    Object? sellingPrice = null,
    Object? costPrice = freezed,
    Object? isActive = null,
    Object? autoAssemble = null,
    Object? canBeSoldSeparately = null,
    Object? assemblyType = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? components = null,
    Object? syncedAt = freezed,
    Object? sku = freezed,
    Object? barcode = freezed,
    Object? categoryId = freezed,
    Object? taxRate = null,
    Object? imageUrl = freezed,
    Object? metadata = null,
    Object? assemblyTime = null,
    Object? assemblyInstructions = freezed,
    Object? trackInventory = null,
    Object? currentStock = null,
    Object? unit = freezed,
    Object? minStock = null,
    Object? maxStock = freezed,
  }) {
    return _then(_$CompositeItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      autoAssemble: null == autoAssemble
          ? _value.autoAssemble
          : autoAssemble // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeSoldSeparately: null == canBeSoldSeparately
          ? _value.canBeSoldSeparately
          : canBeSoldSeparately // ignore: cast_nullable_to_non_nullable
              as bool,
      assemblyType: null == assemblyType
          ? _value.assemblyType
          : assemblyType // ignore: cast_nullable_to_non_nullable
              as AssemblyType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<CompositeItemComponent>,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sku: freezed == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      assemblyTime: null == assemblyTime
          ? _value.assemblyTime
          : assemblyTime // ignore: cast_nullable_to_non_nullable
              as double,
      assemblyInstructions: freezed == assemblyInstructions
          ? _value.assemblyInstructions
          : assemblyInstructions // ignore: cast_nullable_to_non_nullable
              as String?,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      minStock: null == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompositeItemImpl extends _CompositeItem {
  const _$CompositeItemImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      required this.code,
      this.description,
      required this.sellingPrice,
      this.costPrice,
      this.isActive = true,
      this.autoAssemble = false,
      this.canBeSoldSeparately = true,
      this.assemblyType = AssemblyType.manual,
      required this.createdAt,
      required this.updatedAt,
      final List<CompositeItemComponent> components = const [],
      this.syncedAt,
      this.sku,
      this.barcode,
      this.categoryId,
      this.taxRate = 0,
      this.imageUrl,
      final Map<String, dynamic> metadata = const {},
      this.assemblyTime = 0,
      this.assemblyInstructions,
      this.trackInventory = false,
      this.currentStock = 0,
      this.unit,
      this.minStock = 0,
      this.maxStock})
      : _components = components,
        _metadata = metadata,
        super._();

  factory _$CompositeItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompositeItemImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final String code;
  @override
  final String? description;
  @override
  final double sellingPrice;
  @override
  final double? costPrice;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool autoAssemble;
  @override
  @JsonKey()
  final bool canBeSoldSeparately;
  @override
  @JsonKey()
  final AssemblyType assemblyType;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<CompositeItemComponent> _components;
  @override
  @JsonKey()
  List<CompositeItemComponent> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? sku;
  @override
  final String? barcode;
  @override
  final String? categoryId;
  @override
  @JsonKey()
  final double taxRate;
  @override
  final String? imageUrl;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  @JsonKey()
  final double assemblyTime;
// in minutes
  @override
  final String? assemblyInstructions;
  @override
  @JsonKey()
  final bool trackInventory;
  @override
  @JsonKey()
  final double currentStock;
  @override
  final String? unit;
  @override
  @JsonKey()
  final double minStock;
  @override
  final double? maxStock;

  @override
  String toString() {
    return 'CompositeItem(id: $id, organizationId: $organizationId, name: $name, code: $code, description: $description, sellingPrice: $sellingPrice, costPrice: $costPrice, isActive: $isActive, autoAssemble: $autoAssemble, canBeSoldSeparately: $canBeSoldSeparately, assemblyType: $assemblyType, createdAt: $createdAt, updatedAt: $updatedAt, components: $components, syncedAt: $syncedAt, sku: $sku, barcode: $barcode, categoryId: $categoryId, taxRate: $taxRate, imageUrl: $imageUrl, metadata: $metadata, assemblyTime: $assemblyTime, assemblyInstructions: $assemblyInstructions, trackInventory: $trackInventory, currentStock: $currentStock, unit: $unit, minStock: $minStock, maxStock: $maxStock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompositeItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.autoAssemble, autoAssemble) ||
                other.autoAssemble == autoAssemble) &&
            (identical(other.canBeSoldSeparately, canBeSoldSeparately) ||
                other.canBeSoldSeparately == canBeSoldSeparately) &&
            (identical(other.assemblyType, assemblyType) ||
                other.assemblyType == assemblyType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.assemblyTime, assemblyTime) ||
                other.assemblyTime == assemblyTime) &&
            (identical(other.assemblyInstructions, assemblyInstructions) ||
                other.assemblyInstructions == assemblyInstructions) &&
            (identical(other.trackInventory, trackInventory) ||
                other.trackInventory == trackInventory) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.minStock, minStock) ||
                other.minStock == minStock) &&
            (identical(other.maxStock, maxStock) ||
                other.maxStock == maxStock));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        name,
        code,
        description,
        sellingPrice,
        costPrice,
        isActive,
        autoAssemble,
        canBeSoldSeparately,
        assemblyType,
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(_components),
        syncedAt,
        sku,
        barcode,
        categoryId,
        taxRate,
        imageUrl,
        const DeepCollectionEquality().hash(_metadata),
        assemblyTime,
        assemblyInstructions,
        trackInventory,
        currentStock,
        unit,
        minStock,
        maxStock
      ]);

  /// Create a copy of CompositeItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompositeItemImplCopyWith<_$CompositeItemImpl> get copyWith =>
      __$$CompositeItemImplCopyWithImpl<_$CompositeItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompositeItemImplToJson(
      this,
    );
  }
}

abstract class _CompositeItem extends CompositeItem {
  const factory _CompositeItem(
      {required final String id,
      required final String organizationId,
      required final String name,
      required final String code,
      final String? description,
      required final double sellingPrice,
      final double? costPrice,
      final bool isActive,
      final bool autoAssemble,
      final bool canBeSoldSeparately,
      final AssemblyType assemblyType,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final List<CompositeItemComponent> components,
      final DateTime? syncedAt,
      final String? sku,
      final String? barcode,
      final String? categoryId,
      final double taxRate,
      final String? imageUrl,
      final Map<String, dynamic> metadata,
      final double assemblyTime,
      final String? assemblyInstructions,
      final bool trackInventory,
      final double currentStock,
      final String? unit,
      final double minStock,
      final double? maxStock}) = _$CompositeItemImpl;
  const _CompositeItem._() : super._();

  factory _CompositeItem.fromJson(Map<String, dynamic> json) =
      _$CompositeItemImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  String get code;
  @override
  String? get description;
  @override
  double get sellingPrice;
  @override
  double? get costPrice;
  @override
  bool get isActive;
  @override
  bool get autoAssemble;
  @override
  bool get canBeSoldSeparately;
  @override
  AssemblyType get assemblyType;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<CompositeItemComponent> get components;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get sku;
  @override
  String? get barcode;
  @override
  String? get categoryId;
  @override
  double get taxRate;
  @override
  String? get imageUrl;
  @override
  Map<String, dynamic> get metadata;
  @override
  double get assemblyTime; // in minutes
  @override
  String? get assemblyInstructions;
  @override
  bool get trackInventory;
  @override
  double get currentStock;
  @override
  String? get unit;
  @override
  double get minStock;
  @override
  double? get maxStock;

  /// Create a copy of CompositeItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompositeItemImplCopyWith<_$CompositeItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompositeItemComponent _$CompositeItemComponentFromJson(
    Map<String, dynamic> json) {
  return _CompositeItemComponent.fromJson(json);
}

/// @nodoc
mixin _$CompositeItemComponent {
  String get id => throw _privateConstructorUsedError;
  String get compositeItemId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double? get unitCost => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Additional fields for better tracking
  String? get productName => throw _privateConstructorUsedError;
  String? get productSku => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  bool get isOptional => throw _privateConstructorUsedError;
  double? get minQuantity => throw _privateConstructorUsedError;
  double? get maxQuantity => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this CompositeItemComponent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompositeItemComponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompositeItemComponentCopyWith<CompositeItemComponent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompositeItemComponentCopyWith<$Res> {
  factory $CompositeItemComponentCopyWith(CompositeItemComponent value,
          $Res Function(CompositeItemComponent) then) =
      _$CompositeItemComponentCopyWithImpl<$Res, CompositeItemComponent>;
  @useResult
  $Res call(
      {String id,
      String compositeItemId,
      String productId,
      double quantity,
      double? unitCost,
      DateTime createdAt,
      String? productName,
      String? productSku,
      String? unit,
      bool isOptional,
      double? minQuantity,
      double? maxQuantity,
      String? notes,
      int sortOrder});
}

/// @nodoc
class _$CompositeItemComponentCopyWithImpl<$Res,
        $Val extends CompositeItemComponent>
    implements $CompositeItemComponentCopyWith<$Res> {
  _$CompositeItemComponentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompositeItemComponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compositeItemId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? unitCost = freezed,
    Object? createdAt = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? unit = freezed,
    Object? isOptional = null,
    Object? minQuantity = freezed,
    Object? maxQuantity = freezed,
    Object? notes = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      compositeItemId: null == compositeItemId
          ? _value.compositeItemId
          : compositeItemId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      minQuantity: freezed == minQuantity
          ? _value.minQuantity
          : minQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      maxQuantity: freezed == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompositeItemComponentImplCopyWith<$Res>
    implements $CompositeItemComponentCopyWith<$Res> {
  factory _$$CompositeItemComponentImplCopyWith(
          _$CompositeItemComponentImpl value,
          $Res Function(_$CompositeItemComponentImpl) then) =
      __$$CompositeItemComponentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String compositeItemId,
      String productId,
      double quantity,
      double? unitCost,
      DateTime createdAt,
      String? productName,
      String? productSku,
      String? unit,
      bool isOptional,
      double? minQuantity,
      double? maxQuantity,
      String? notes,
      int sortOrder});
}

/// @nodoc
class __$$CompositeItemComponentImplCopyWithImpl<$Res>
    extends _$CompositeItemComponentCopyWithImpl<$Res,
        _$CompositeItemComponentImpl>
    implements _$$CompositeItemComponentImplCopyWith<$Res> {
  __$$CompositeItemComponentImplCopyWithImpl(
      _$CompositeItemComponentImpl _value,
      $Res Function(_$CompositeItemComponentImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompositeItemComponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compositeItemId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? unitCost = freezed,
    Object? createdAt = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? unit = freezed,
    Object? isOptional = null,
    Object? minQuantity = freezed,
    Object? maxQuantity = freezed,
    Object? notes = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_$CompositeItemComponentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      compositeItemId: null == compositeItemId
          ? _value.compositeItemId
          : compositeItemId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      isOptional: null == isOptional
          ? _value.isOptional
          : isOptional // ignore: cast_nullable_to_non_nullable
              as bool,
      minQuantity: freezed == minQuantity
          ? _value.minQuantity
          : minQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      maxQuantity: freezed == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompositeItemComponentImpl extends _CompositeItemComponent {
  const _$CompositeItemComponentImpl(
      {required this.id,
      required this.compositeItemId,
      required this.productId,
      required this.quantity,
      this.unitCost,
      required this.createdAt,
      this.productName,
      this.productSku,
      this.unit,
      this.isOptional = false,
      this.minQuantity,
      this.maxQuantity,
      this.notes,
      this.sortOrder = 1})
      : super._();

  factory _$CompositeItemComponentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompositeItemComponentImplFromJson(json);

  @override
  final String id;
  @override
  final String compositeItemId;
  @override
  final String productId;
  @override
  final double quantity;
  @override
  final double? unitCost;
  @override
  final DateTime createdAt;
// Additional fields for better tracking
  @override
  final String? productName;
  @override
  final String? productSku;
  @override
  final String? unit;
  @override
  @JsonKey()
  final bool isOptional;
  @override
  final double? minQuantity;
  @override
  final double? maxQuantity;
  @override
  final String? notes;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'CompositeItemComponent(id: $id, compositeItemId: $compositeItemId, productId: $productId, quantity: $quantity, unitCost: $unitCost, createdAt: $createdAt, productName: $productName, productSku: $productSku, unit: $unit, isOptional: $isOptional, minQuantity: $minQuantity, maxQuantity: $maxQuantity, notes: $notes, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompositeItemComponentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.compositeItemId, compositeItemId) ||
                other.compositeItemId == compositeItemId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productSku, productSku) ||
                other.productSku == productSku) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.isOptional, isOptional) ||
                other.isOptional == isOptional) &&
            (identical(other.minQuantity, minQuantity) ||
                other.minQuantity == minQuantity) &&
            (identical(other.maxQuantity, maxQuantity) ||
                other.maxQuantity == maxQuantity) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      compositeItemId,
      productId,
      quantity,
      unitCost,
      createdAt,
      productName,
      productSku,
      unit,
      isOptional,
      minQuantity,
      maxQuantity,
      notes,
      sortOrder);

  /// Create a copy of CompositeItemComponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompositeItemComponentImplCopyWith<_$CompositeItemComponentImpl>
      get copyWith => __$$CompositeItemComponentImplCopyWithImpl<
          _$CompositeItemComponentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompositeItemComponentImplToJson(
      this,
    );
  }
}

abstract class _CompositeItemComponent extends CompositeItemComponent {
  const factory _CompositeItemComponent(
      {required final String id,
      required final String compositeItemId,
      required final String productId,
      required final double quantity,
      final double? unitCost,
      required final DateTime createdAt,
      final String? productName,
      final String? productSku,
      final String? unit,
      final bool isOptional,
      final double? minQuantity,
      final double? maxQuantity,
      final String? notes,
      final int sortOrder}) = _$CompositeItemComponentImpl;
  const _CompositeItemComponent._() : super._();

  factory _CompositeItemComponent.fromJson(Map<String, dynamic> json) =
      _$CompositeItemComponentImpl.fromJson;

  @override
  String get id;
  @override
  String get compositeItemId;
  @override
  String get productId;
  @override
  double get quantity;
  @override
  double? get unitCost;
  @override
  DateTime get createdAt; // Additional fields for better tracking
  @override
  String? get productName;
  @override
  String? get productSku;
  @override
  String? get unit;
  @override
  bool get isOptional;
  @override
  double? get minQuantity;
  @override
  double? get maxQuantity;
  @override
  String? get notes;
  @override
  int get sortOrder;

  /// Create a copy of CompositeItemComponent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompositeItemComponentImplCopyWith<_$CompositeItemComponentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CompositeItemAssembly _$CompositeItemAssemblyFromJson(
    Map<String, dynamic> json) {
  return _CompositeItemAssembly.fromJson(json);
}

/// @nodoc
mixin _$CompositeItemAssembly {
  String get id => throw _privateConstructorUsedError;
  String get compositeItemId => throw _privateConstructorUsedError;
  String get branchId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  DateTime get assemblyDate => throw _privateConstructorUsedError;
  String get assembledBy => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, double> get componentsUsed => throw _privateConstructorUsedError;
  double? get totalCost => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CompositeItemAssembly to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompositeItemAssembly
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompositeItemAssemblyCopyWith<CompositeItemAssembly> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompositeItemAssemblyCopyWith<$Res> {
  factory $CompositeItemAssemblyCopyWith(CompositeItemAssembly value,
          $Res Function(CompositeItemAssembly) then) =
      _$CompositeItemAssemblyCopyWithImpl<$Res, CompositeItemAssembly>;
  @useResult
  $Res call(
      {String id,
      String compositeItemId,
      String branchId,
      double quantity,
      DateTime assemblyDate,
      String assembledBy,
      String status,
      DateTime? completedAt,
      String? notes,
      Map<String, double> componentsUsed,
      double? totalCost,
      DateTime createdAt});
}

/// @nodoc
class _$CompositeItemAssemblyCopyWithImpl<$Res,
        $Val extends CompositeItemAssembly>
    implements $CompositeItemAssemblyCopyWith<$Res> {
  _$CompositeItemAssemblyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompositeItemAssembly
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compositeItemId = null,
    Object? branchId = null,
    Object? quantity = null,
    Object? assemblyDate = null,
    Object? assembledBy = null,
    Object? status = null,
    Object? completedAt = freezed,
    Object? notes = freezed,
    Object? componentsUsed = null,
    Object? totalCost = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      compositeItemId: null == compositeItemId
          ? _value.compositeItemId
          : compositeItemId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      assemblyDate: null == assemblyDate
          ? _value.assemblyDate
          : assemblyDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assembledBy: null == assembledBy
          ? _value.assembledBy
          : assembledBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      componentsUsed: null == componentsUsed
          ? _value.componentsUsed
          : componentsUsed // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompositeItemAssemblyImplCopyWith<$Res>
    implements $CompositeItemAssemblyCopyWith<$Res> {
  factory _$$CompositeItemAssemblyImplCopyWith(
          _$CompositeItemAssemblyImpl value,
          $Res Function(_$CompositeItemAssemblyImpl) then) =
      __$$CompositeItemAssemblyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String compositeItemId,
      String branchId,
      double quantity,
      DateTime assemblyDate,
      String assembledBy,
      String status,
      DateTime? completedAt,
      String? notes,
      Map<String, double> componentsUsed,
      double? totalCost,
      DateTime createdAt});
}

/// @nodoc
class __$$CompositeItemAssemblyImplCopyWithImpl<$Res>
    extends _$CompositeItemAssemblyCopyWithImpl<$Res,
        _$CompositeItemAssemblyImpl>
    implements _$$CompositeItemAssemblyImplCopyWith<$Res> {
  __$$CompositeItemAssemblyImplCopyWithImpl(_$CompositeItemAssemblyImpl _value,
      $Res Function(_$CompositeItemAssemblyImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompositeItemAssembly
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compositeItemId = null,
    Object? branchId = null,
    Object? quantity = null,
    Object? assemblyDate = null,
    Object? assembledBy = null,
    Object? status = null,
    Object? completedAt = freezed,
    Object? notes = freezed,
    Object? componentsUsed = null,
    Object? totalCost = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$CompositeItemAssemblyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      compositeItemId: null == compositeItemId
          ? _value.compositeItemId
          : compositeItemId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      assemblyDate: null == assemblyDate
          ? _value.assemblyDate
          : assemblyDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assembledBy: null == assembledBy
          ? _value.assembledBy
          : assembledBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      componentsUsed: null == componentsUsed
          ? _value._componentsUsed
          : componentsUsed // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompositeItemAssemblyImpl implements _CompositeItemAssembly {
  const _$CompositeItemAssemblyImpl(
      {required this.id,
      required this.compositeItemId,
      required this.branchId,
      required this.quantity,
      required this.assemblyDate,
      required this.assembledBy,
      this.status = 'pending',
      this.completedAt,
      this.notes,
      final Map<String, double> componentsUsed = const {},
      this.totalCost,
      required this.createdAt})
      : _componentsUsed = componentsUsed;

  factory _$CompositeItemAssemblyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompositeItemAssemblyImplFromJson(json);

  @override
  final String id;
  @override
  final String compositeItemId;
  @override
  final String branchId;
  @override
  final double quantity;
  @override
  final DateTime assemblyDate;
  @override
  final String assembledBy;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? completedAt;
  @override
  final String? notes;
  final Map<String, double> _componentsUsed;
  @override
  @JsonKey()
  Map<String, double> get componentsUsed {
    if (_componentsUsed is EqualUnmodifiableMapView) return _componentsUsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_componentsUsed);
  }

  @override
  final double? totalCost;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'CompositeItemAssembly(id: $id, compositeItemId: $compositeItemId, branchId: $branchId, quantity: $quantity, assemblyDate: $assemblyDate, assembledBy: $assembledBy, status: $status, completedAt: $completedAt, notes: $notes, componentsUsed: $componentsUsed, totalCost: $totalCost, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompositeItemAssemblyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.compositeItemId, compositeItemId) ||
                other.compositeItemId == compositeItemId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.assemblyDate, assemblyDate) ||
                other.assemblyDate == assemblyDate) &&
            (identical(other.assembledBy, assembledBy) ||
                other.assembledBy == assembledBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._componentsUsed, _componentsUsed) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      compositeItemId,
      branchId,
      quantity,
      assemblyDate,
      assembledBy,
      status,
      completedAt,
      notes,
      const DeepCollectionEquality().hash(_componentsUsed),
      totalCost,
      createdAt);

  /// Create a copy of CompositeItemAssembly
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompositeItemAssemblyImplCopyWith<_$CompositeItemAssemblyImpl>
      get copyWith => __$$CompositeItemAssemblyImplCopyWithImpl<
          _$CompositeItemAssemblyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompositeItemAssemblyImplToJson(
      this,
    );
  }
}

abstract class _CompositeItemAssembly implements CompositeItemAssembly {
  const factory _CompositeItemAssembly(
      {required final String id,
      required final String compositeItemId,
      required final String branchId,
      required final double quantity,
      required final DateTime assemblyDate,
      required final String assembledBy,
      final String status,
      final DateTime? completedAt,
      final String? notes,
      final Map<String, double> componentsUsed,
      final double? totalCost,
      required final DateTime createdAt}) = _$CompositeItemAssemblyImpl;

  factory _CompositeItemAssembly.fromJson(Map<String, dynamic> json) =
      _$CompositeItemAssemblyImpl.fromJson;

  @override
  String get id;
  @override
  String get compositeItemId;
  @override
  String get branchId;
  @override
  double get quantity;
  @override
  DateTime get assemblyDate;
  @override
  String get assembledBy;
  @override
  String get status;
  @override
  DateTime? get completedAt;
  @override
  String? get notes;
  @override
  Map<String, double> get componentsUsed;
  @override
  double? get totalCost;
  @override
  DateTime get createdAt;

  /// Create a copy of CompositeItemAssembly
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompositeItemAssemblyImplCopyWith<_$CompositeItemAssemblyImpl>
      get copyWith => throw _privateConstructorUsedError;
}
