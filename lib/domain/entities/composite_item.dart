import 'package:equatable/equatable.dart';

class CompositeItem extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String code;
  final String? description;
  final double sellingPrice;
  final double? costPrice;
  final bool isActive;
  final bool autoAssemble;
  final bool canBeSoldSeparately;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CompositeItemComponent>? components;

  const CompositeItem({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.code,
    this.description,
    required this.sellingPrice,
    this.costPrice,
    required this.isActive,
    required this.autoAssemble,
    this.canBeSoldSeparately = true,
    required this.createdAt,
    required this.updatedAt,
    this.components,
  });

  CompositeItem copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? code,
    String? description,
    double? sellingPrice,
    double? costPrice,
    bool? isActive,
    bool? autoAssemble,
    bool? canBeSoldSeparately,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CompositeItemComponent>? components,
  }) {
    return CompositeItem(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      costPrice: costPrice ?? this.costPrice,
      isActive: isActive ?? this.isActive,
      autoAssemble: autoAssemble ?? this.autoAssemble,
      canBeSoldSeparately: canBeSoldSeparately ?? this.canBeSoldSeparately,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      components: components ?? this.components,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'code': code,
      'description': description,
      'selling_price': sellingPrice,
      'cost_price': costPrice,
      'is_active': isActive ? 1 : 0,
      'auto_assemble': autoAssemble ? 1 : 0,
      'can_be_sold_separately': canBeSoldSeparately ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CompositeItem.fromMap(Map<String, dynamic> map) {
    return CompositeItem(
      id: map['id'],
      organizationId: map['organization_id'],
      name: map['name'],
      code: map['code'],
      description: map['description'],
      sellingPrice: map['selling_price']?.toDouble() ?? 0.0,
      costPrice: map['cost_price']?.toDouble(),
      isActive: map['is_active'] == 1,
      autoAssemble: map['auto_assemble'] == 1,
      canBeSoldSeparately: map['can_be_sold_separately'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  double get calculatedCostPrice {
    if (components == null || components!.isEmpty) return costPrice ?? 0.0;
    
    // Calculate cost based on component prices
    // This would need product prices from a service
    return costPrice ?? 0.0;
  }

  double get profitMargin {
    final cost = calculatedCostPrice;
    if (cost == 0) return 0;
    return ((sellingPrice - cost) / cost) * 100;
  }

  double get totalCost => calculatedCostPrice;

  @override
  List<Object?> get props => [
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
        createdAt,
        updatedAt,
        components,
      ];
}

class CompositeItemComponent extends Equatable {
  final String id;
  final String compositeItemId;
  final String productId;
  final double quantity;
  final double? costPrice;
  final DateTime createdAt;

  const CompositeItemComponent({
    required this.id,
    required this.compositeItemId,
    required this.productId,
    required this.quantity,
    this.costPrice,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'composite_item_id': compositeItemId,
      'product_id': productId,
      'quantity': quantity,
      'cost_price': costPrice,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CompositeItemComponent.fromMap(Map<String, dynamic> map) {
    return CompositeItemComponent(
      id: map['id'],
      compositeItemId: map['composite_item_id'],
      productId: map['product_id'],
      quantity: map['quantity']?.toDouble() ?? 0.0,
      costPrice: map['cost_price']?.toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        compositeItemId,
        productId,
        quantity,
        costPrice,
        createdAt,
      ];
}