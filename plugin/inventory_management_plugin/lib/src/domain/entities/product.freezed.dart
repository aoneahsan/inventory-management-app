// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  double get stockQuantity => throw _privateConstructorUsedError;
  double get reorderPoint => throw _privateConstructorUsedError;
  double get reorderQuantity => throw _privateConstructorUsedError;
  double get costPrice => throw _privateConstructorUsedError;
  double get sellingPrice => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isComposite => throw _privateConstructorUsedError;
  bool get trackInventory => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields from plugin requirements
  String? get hsn => throw _privateConstructorUsedError;
  String? get sac => throw _privateConstructorUsedError;
  double get minStock => throw _privateConstructorUsedError;
  double? get maxStock => throw _privateConstructorUsedError;
  String? get warehouseLocation => throw _privateConstructorUsedError;
  String? get supplierId => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  ProductVariants? get variants => throw _privateConstructorUsedError;
  Map<String, double> get branchStock =>
      throw _privateConstructorUsedError; // branchId -> stock
  bool get trackSerialNumbers => throw _privateConstructorUsedError;
  bool get trackBatches => throw _privateConstructorUsedError;
  int get shelfLifeDays => throw _privateConstructorUsedError;
  String? get customFields => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String sku,
      String? barcode,
      String? description,
      String? categoryId,
      String unit,
      double stockQuantity,
      double reorderPoint,
      double reorderQuantity,
      double costPrice,
      double sellingPrice,
      double taxRate,
      String? imageUrl,
      bool isActive,
      bool isComposite,
      bool trackInventory,
      Map<String, dynamic> metadata,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? hsn,
      String? sac,
      double minStock,
      double? maxStock,
      String? warehouseLocation,
      String? supplierId,
      String? brandName,
      List<String> tags,
      ProductVariants? variants,
      Map<String, double> branchStock,
      bool trackSerialNumbers,
      bool trackBatches,
      int shelfLifeDays,
      String? customFields});

  $ProductVariantsCopyWith<$Res>? get variants;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? sku = null,
    Object? barcode = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? unit = null,
    Object? stockQuantity = null,
    Object? reorderPoint = null,
    Object? reorderQuantity = null,
    Object? costPrice = null,
    Object? sellingPrice = null,
    Object? taxRate = null,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? isComposite = null,
    Object? trackInventory = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? hsn = freezed,
    Object? sac = freezed,
    Object? minStock = null,
    Object? maxStock = freezed,
    Object? warehouseLocation = freezed,
    Object? supplierId = freezed,
    Object? brandName = freezed,
    Object? tags = null,
    Object? variants = freezed,
    Object? branchStock = null,
    Object? trackSerialNumbers = null,
    Object? trackBatches = null,
    Object? shelfLifeDays = null,
    Object? customFields = freezed,
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
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      reorderPoint: null == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double,
      reorderQuantity: null == reorderQuantity
          ? _value.reorderQuantity
          : reorderQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: null == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isComposite: null == isComposite
          ? _value.isComposite
          : isComposite // ignore: cast_nullable_to_non_nullable
              as bool,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hsn: freezed == hsn
          ? _value.hsn
          : hsn // ignore: cast_nullable_to_non_nullable
              as String?,
      sac: freezed == sac
          ? _value.sac
          : sac // ignore: cast_nullable_to_non_nullable
              as String?,
      minStock: null == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      variants: freezed == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as ProductVariants?,
      branchStock: null == branchStock
          ? _value.branchStock
          : branchStock // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      trackSerialNumbers: null == trackSerialNumbers
          ? _value.trackSerialNumbers
          : trackSerialNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      trackBatches: null == trackBatches
          ? _value.trackBatches
          : trackBatches // ignore: cast_nullable_to_non_nullable
              as bool,
      shelfLifeDays: null == shelfLifeDays
          ? _value.shelfLifeDays
          : shelfLifeDays // ignore: cast_nullable_to_non_nullable
              as int,
      customFields: freezed == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductVariantsCopyWith<$Res>? get variants {
    if (_value.variants == null) {
      return null;
    }

    return $ProductVariantsCopyWith<$Res>(_value.variants!, (value) {
      return _then(_value.copyWith(variants: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String sku,
      String? barcode,
      String? description,
      String? categoryId,
      String unit,
      double stockQuantity,
      double reorderPoint,
      double reorderQuantity,
      double costPrice,
      double sellingPrice,
      double taxRate,
      String? imageUrl,
      bool isActive,
      bool isComposite,
      bool trackInventory,
      Map<String, dynamic> metadata,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? hsn,
      String? sac,
      double minStock,
      double? maxStock,
      String? warehouseLocation,
      String? supplierId,
      String? brandName,
      List<String> tags,
      ProductVariants? variants,
      Map<String, double> branchStock,
      bool trackSerialNumbers,
      bool trackBatches,
      int shelfLifeDays,
      String? customFields});

  @override
  $ProductVariantsCopyWith<$Res>? get variants;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? sku = null,
    Object? barcode = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? unit = null,
    Object? stockQuantity = null,
    Object? reorderPoint = null,
    Object? reorderQuantity = null,
    Object? costPrice = null,
    Object? sellingPrice = null,
    Object? taxRate = null,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? isComposite = null,
    Object? trackInventory = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? hsn = freezed,
    Object? sac = freezed,
    Object? minStock = null,
    Object? maxStock = freezed,
    Object? warehouseLocation = freezed,
    Object? supplierId = freezed,
    Object? brandName = freezed,
    Object? tags = null,
    Object? variants = freezed,
    Object? branchStock = null,
    Object? trackSerialNumbers = null,
    Object? trackBatches = null,
    Object? shelfLifeDays = null,
    Object? customFields = freezed,
  }) {
    return _then(_$ProductImpl(
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
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      reorderPoint: null == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double,
      reorderQuantity: null == reorderQuantity
          ? _value.reorderQuantity
          : reorderQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: null == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isComposite: null == isComposite
          ? _value.isComposite
          : isComposite // ignore: cast_nullable_to_non_nullable
              as bool,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hsn: freezed == hsn
          ? _value.hsn
          : hsn // ignore: cast_nullable_to_non_nullable
              as String?,
      sac: freezed == sac
          ? _value.sac
          : sac // ignore: cast_nullable_to_non_nullable
              as String?,
      minStock: null == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      variants: freezed == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as ProductVariants?,
      branchStock: null == branchStock
          ? _value._branchStock
          : branchStock // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      trackSerialNumbers: null == trackSerialNumbers
          ? _value.trackSerialNumbers
          : trackSerialNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      trackBatches: null == trackBatches
          ? _value.trackBatches
          : trackBatches // ignore: cast_nullable_to_non_nullable
              as bool,
      shelfLifeDays: null == shelfLifeDays
          ? _value.shelfLifeDays
          : shelfLifeDays // ignore: cast_nullable_to_non_nullable
              as int,
      customFields: freezed == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl extends _Product {
  const _$ProductImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      required this.sku,
      this.barcode,
      this.description,
      this.categoryId,
      this.unit = 'pcs',
      this.stockQuantity = 0,
      this.reorderPoint = 0,
      this.reorderQuantity = 0,
      this.costPrice = 0,
      this.sellingPrice = 0,
      this.taxRate = 0,
      this.imageUrl,
      this.isActive = true,
      this.isComposite = false,
      this.trackInventory = true,
      final Map<String, dynamic> metadata = const {},
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.hsn,
      this.sac,
      this.minStock = 0,
      this.maxStock,
      this.warehouseLocation,
      this.supplierId,
      this.brandName,
      final List<String> tags = const [],
      this.variants,
      final Map<String, double> branchStock = const {},
      this.trackSerialNumbers = false,
      this.trackBatches = false,
      this.shelfLifeDays = 30,
      this.customFields})
      : _metadata = metadata,
        _tags = tags,
        _branchStock = branchStock,
        super._();

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final String sku;
  @override
  final String? barcode;
  @override
  final String? description;
  @override
  final String? categoryId;
  @override
  @JsonKey()
  final String unit;
  @override
  @JsonKey()
  final double stockQuantity;
  @override
  @JsonKey()
  final double reorderPoint;
  @override
  @JsonKey()
  final double reorderQuantity;
  @override
  @JsonKey()
  final double costPrice;
  @override
  @JsonKey()
  final double sellingPrice;
  @override
  @JsonKey()
  final double taxRate;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isComposite;
  @override
  @JsonKey()
  final bool trackInventory;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields from plugin requirements
  @override
  final String? hsn;
  @override
  final String? sac;
  @override
  @JsonKey()
  final double minStock;
  @override
  final double? maxStock;
  @override
  final String? warehouseLocation;
  @override
  final String? supplierId;
  @override
  final String? brandName;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final ProductVariants? variants;
  final Map<String, double> _branchStock;
  @override
  @JsonKey()
  Map<String, double> get branchStock {
    if (_branchStock is EqualUnmodifiableMapView) return _branchStock;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_branchStock);
  }

// branchId -> stock
  @override
  @JsonKey()
  final bool trackSerialNumbers;
  @override
  @JsonKey()
  final bool trackBatches;
  @override
  @JsonKey()
  final int shelfLifeDays;
  @override
  final String? customFields;

  @override
  String toString() {
    return 'Product(id: $id, organizationId: $organizationId, name: $name, sku: $sku, barcode: $barcode, description: $description, categoryId: $categoryId, unit: $unit, stockQuantity: $stockQuantity, reorderPoint: $reorderPoint, reorderQuantity: $reorderQuantity, costPrice: $costPrice, sellingPrice: $sellingPrice, taxRate: $taxRate, imageUrl: $imageUrl, isActive: $isActive, isComposite: $isComposite, trackInventory: $trackInventory, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, hsn: $hsn, sac: $sac, minStock: $minStock, maxStock: $maxStock, warehouseLocation: $warehouseLocation, supplierId: $supplierId, brandName: $brandName, tags: $tags, variants: $variants, branchStock: $branchStock, trackSerialNumbers: $trackSerialNumbers, trackBatches: $trackBatches, shelfLifeDays: $shelfLifeDays, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.reorderPoint, reorderPoint) ||
                other.reorderPoint == reorderPoint) &&
            (identical(other.reorderQuantity, reorderQuantity) ||
                other.reorderQuantity == reorderQuantity) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isComposite, isComposite) ||
                other.isComposite == isComposite) &&
            (identical(other.trackInventory, trackInventory) ||
                other.trackInventory == trackInventory) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.hsn, hsn) || other.hsn == hsn) &&
            (identical(other.sac, sac) || other.sac == sac) &&
            (identical(other.minStock, minStock) ||
                other.minStock == minStock) &&
            (identical(other.maxStock, maxStock) ||
                other.maxStock == maxStock) &&
            (identical(other.warehouseLocation, warehouseLocation) ||
                other.warehouseLocation == warehouseLocation) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.variants, variants) ||
                other.variants == variants) &&
            const DeepCollectionEquality()
                .equals(other._branchStock, _branchStock) &&
            (identical(other.trackSerialNumbers, trackSerialNumbers) ||
                other.trackSerialNumbers == trackSerialNumbers) &&
            (identical(other.trackBatches, trackBatches) ||
                other.trackBatches == trackBatches) &&
            (identical(other.shelfLifeDays, shelfLifeDays) ||
                other.shelfLifeDays == shelfLifeDays) &&
            (identical(other.customFields, customFields) ||
                other.customFields == customFields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        name,
        sku,
        barcode,
        description,
        categoryId,
        unit,
        stockQuantity,
        reorderPoint,
        reorderQuantity,
        costPrice,
        sellingPrice,
        taxRate,
        imageUrl,
        isActive,
        isComposite,
        trackInventory,
        const DeepCollectionEquality().hash(_metadata),
        createdAt,
        updatedAt,
        syncedAt,
        hsn,
        sac,
        minStock,
        maxStock,
        warehouseLocation,
        supplierId,
        brandName,
        const DeepCollectionEquality().hash(_tags),
        variants,
        const DeepCollectionEquality().hash(_branchStock),
        trackSerialNumbers,
        trackBatches,
        shelfLifeDays,
        customFields
      ]);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product extends Product {
  const factory _Product(
      {required final String id,
      required final String organizationId,
      required final String name,
      required final String sku,
      final String? barcode,
      final String? description,
      final String? categoryId,
      final String unit,
      final double stockQuantity,
      final double reorderPoint,
      final double reorderQuantity,
      final double costPrice,
      final double sellingPrice,
      final double taxRate,
      final String? imageUrl,
      final bool isActive,
      final bool isComposite,
      final bool trackInventory,
      final Map<String, dynamic> metadata,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? hsn,
      final String? sac,
      final double minStock,
      final double? maxStock,
      final String? warehouseLocation,
      final String? supplierId,
      final String? brandName,
      final List<String> tags,
      final ProductVariants? variants,
      final Map<String, double> branchStock,
      final bool trackSerialNumbers,
      final bool trackBatches,
      final int shelfLifeDays,
      final String? customFields}) = _$ProductImpl;
  const _Product._() : super._();

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  String get sku;
  @override
  String? get barcode;
  @override
  String? get description;
  @override
  String? get categoryId;
  @override
  String get unit;
  @override
  double get stockQuantity;
  @override
  double get reorderPoint;
  @override
  double get reorderQuantity;
  @override
  double get costPrice;
  @override
  double get sellingPrice;
  @override
  double get taxRate;
  @override
  String? get imageUrl;
  @override
  bool get isActive;
  @override
  bool get isComposite;
  @override
  bool get trackInventory;
  @override
  Map<String, dynamic> get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields from plugin requirements
  @override
  String? get hsn;
  @override
  String? get sac;
  @override
  double get minStock;
  @override
  double? get maxStock;
  @override
  String? get warehouseLocation;
  @override
  String? get supplierId;
  @override
  String? get brandName;
  @override
  List<String> get tags;
  @override
  ProductVariants? get variants;
  @override
  Map<String, double> get branchStock; // branchId -> stock
  @override
  bool get trackSerialNumbers;
  @override
  bool get trackBatches;
  @override
  int get shelfLifeDays;
  @override
  String? get customFields;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductVariants _$ProductVariantsFromJson(Map<String, dynamic> json) {
  return _ProductVariants.fromJson(json);
}

/// @nodoc
mixin _$ProductVariants {
  Map<String, List<String>> get attributes =>
      throw _privateConstructorUsedError; // e.g., {"color": ["red", "blue"], "size": ["S", "M", "L"]}
  List<ProductVariant> get variants => throw _privateConstructorUsedError;

  /// Serializes this ProductVariants to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductVariantsCopyWith<ProductVariants> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductVariantsCopyWith<$Res> {
  factory $ProductVariantsCopyWith(
          ProductVariants value, $Res Function(ProductVariants) then) =
      _$ProductVariantsCopyWithImpl<$Res, ProductVariants>;
  @useResult
  $Res call(
      {Map<String, List<String>> attributes, List<ProductVariant> variants});
}

/// @nodoc
class _$ProductVariantsCopyWithImpl<$Res, $Val extends ProductVariants>
    implements $ProductVariantsCopyWith<$Res> {
  _$ProductVariantsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributes = null,
    Object? variants = null,
  }) {
    return _then(_value.copyWith(
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariant>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductVariantsImplCopyWith<$Res>
    implements $ProductVariantsCopyWith<$Res> {
  factory _$$ProductVariantsImplCopyWith(_$ProductVariantsImpl value,
          $Res Function(_$ProductVariantsImpl) then) =
      __$$ProductVariantsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<String>> attributes, List<ProductVariant> variants});
}

/// @nodoc
class __$$ProductVariantsImplCopyWithImpl<$Res>
    extends _$ProductVariantsCopyWithImpl<$Res, _$ProductVariantsImpl>
    implements _$$ProductVariantsImplCopyWith<$Res> {
  __$$ProductVariantsImplCopyWithImpl(
      _$ProductVariantsImpl _value, $Res Function(_$ProductVariantsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributes = null,
    Object? variants = null,
  }) {
    return _then(_$ProductVariantsImpl(
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      variants: null == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariant>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductVariantsImpl implements _ProductVariants {
  const _$ProductVariantsImpl(
      {final Map<String, List<String>> attributes = const {},
      final List<ProductVariant> variants = const []})
      : _attributes = attributes,
        _variants = variants;

  factory _$ProductVariantsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductVariantsImplFromJson(json);

  final Map<String, List<String>> _attributes;
  @override
  @JsonKey()
  Map<String, List<String>> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

// e.g., {"color": ["red", "blue"], "size": ["S", "M", "L"]}
  final List<ProductVariant> _variants;
// e.g., {"color": ["red", "blue"], "size": ["S", "M", "L"]}
  @override
  @JsonKey()
  List<ProductVariant> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'ProductVariants(attributes: $attributes, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductVariantsImpl &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_attributes),
      const DeepCollectionEquality().hash(_variants));

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductVariantsImplCopyWith<_$ProductVariantsImpl> get copyWith =>
      __$$ProductVariantsImplCopyWithImpl<_$ProductVariantsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductVariantsImplToJson(
      this,
    );
  }
}

abstract class _ProductVariants implements ProductVariants {
  const factory _ProductVariants(
      {final Map<String, List<String>> attributes,
      final List<ProductVariant> variants}) = _$ProductVariantsImpl;

  factory _ProductVariants.fromJson(Map<String, dynamic> json) =
      _$ProductVariantsImpl.fromJson;

  @override
  Map<String, List<String>>
      get attributes; // e.g., {"color": ["red", "blue"], "size": ["S", "M", "L"]}
  @override
  List<ProductVariant> get variants;

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductVariantsImplCopyWith<_$ProductVariantsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) {
  return _ProductVariant.fromJson(json);
}

/// @nodoc
mixin _$ProductVariant {
  String get id => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  Map<String, String> get attributes =>
      throw _privateConstructorUsedError; // e.g., {"color": "red", "size": "M"}
  double get stockQuantity => throw _privateConstructorUsedError;
  double? get costPrice => throw _privateConstructorUsedError;
  double? get sellingPrice => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this ProductVariant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductVariantCopyWith<ProductVariant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductVariantCopyWith<$Res> {
  factory $ProductVariantCopyWith(
          ProductVariant value, $Res Function(ProductVariant) then) =
      _$ProductVariantCopyWithImpl<$Res, ProductVariant>;
  @useResult
  $Res call(
      {String id,
      String sku,
      String? barcode,
      Map<String, String> attributes,
      double stockQuantity,
      double? costPrice,
      double? sellingPrice,
      String? imageUrl,
      bool isActive});
}

/// @nodoc
class _$ProductVariantCopyWithImpl<$Res, $Val extends ProductVariant>
    implements $ProductVariantCopyWith<$Res> {
  _$ProductVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? barcode = freezed,
    Object? attributes = null,
    Object? stockQuantity = null,
    Object? costPrice = freezed,
    Object? sellingPrice = freezed,
    Object? imageUrl = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      sellingPrice: freezed == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductVariantImplCopyWith<$Res>
    implements $ProductVariantCopyWith<$Res> {
  factory _$$ProductVariantImplCopyWith(_$ProductVariantImpl value,
          $Res Function(_$ProductVariantImpl) then) =
      __$$ProductVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sku,
      String? barcode,
      Map<String, String> attributes,
      double stockQuantity,
      double? costPrice,
      double? sellingPrice,
      String? imageUrl,
      bool isActive});
}

/// @nodoc
class __$$ProductVariantImplCopyWithImpl<$Res>
    extends _$ProductVariantCopyWithImpl<$Res, _$ProductVariantImpl>
    implements _$$ProductVariantImplCopyWith<$Res> {
  __$$ProductVariantImplCopyWithImpl(
      _$ProductVariantImpl _value, $Res Function(_$ProductVariantImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? barcode = freezed,
    Object? attributes = null,
    Object? stockQuantity = null,
    Object? costPrice = freezed,
    Object? sellingPrice = freezed,
    Object? imageUrl = freezed,
    Object? isActive = null,
  }) {
    return _then(_$ProductVariantImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      sellingPrice: freezed == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductVariantImpl implements _ProductVariant {
  const _$ProductVariantImpl(
      {required this.id,
      required this.sku,
      this.barcode,
      required final Map<String, String> attributes,
      this.stockQuantity = 0,
      this.costPrice,
      this.sellingPrice,
      this.imageUrl,
      this.isActive = true})
      : _attributes = attributes;

  factory _$ProductVariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductVariantImplFromJson(json);

  @override
  final String id;
  @override
  final String sku;
  @override
  final String? barcode;
  final Map<String, String> _attributes;
  @override
  Map<String, String> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

// e.g., {"color": "red", "size": "M"}
  @override
  @JsonKey()
  final double stockQuantity;
  @override
  final double? costPrice;
  @override
  final double? sellingPrice;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'ProductVariant(id: $id, sku: $sku, barcode: $barcode, attributes: $attributes, stockQuantity: $stockQuantity, costPrice: $costPrice, sellingPrice: $sellingPrice, imageUrl: $imageUrl, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductVariantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sku,
      barcode,
      const DeepCollectionEquality().hash(_attributes),
      stockQuantity,
      costPrice,
      sellingPrice,
      imageUrl,
      isActive);

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductVariantImplCopyWith<_$ProductVariantImpl> get copyWith =>
      __$$ProductVariantImplCopyWithImpl<_$ProductVariantImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductVariantImplToJson(
      this,
    );
  }
}

abstract class _ProductVariant implements ProductVariant {
  const factory _ProductVariant(
      {required final String id,
      required final String sku,
      final String? barcode,
      required final Map<String, String> attributes,
      final double stockQuantity,
      final double? costPrice,
      final double? sellingPrice,
      final String? imageUrl,
      final bool isActive}) = _$ProductVariantImpl;

  factory _ProductVariant.fromJson(Map<String, dynamic> json) =
      _$ProductVariantImpl.fromJson;

  @override
  String get id;
  @override
  String get sku;
  @override
  String? get barcode;
  @override
  Map<String, String> get attributes; // e.g., {"color": "red", "size": "M"}
  @override
  double get stockQuantity;
  @override
  double? get costPrice;
  @override
  double? get sellingPrice;
  @override
  String? get imageUrl;
  @override
  bool get isActive;

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductVariantImplCopyWith<_$ProductVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
