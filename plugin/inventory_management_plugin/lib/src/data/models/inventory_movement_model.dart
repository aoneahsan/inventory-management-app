import 'dart:convert';

import '../../domain/entities/inventory_movement.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for InventoryMovement entity
class InventoryMovementModel extends BaseModel {
  final InventoryMovement movement;
  
  InventoryMovementModel(this.movement);
  
  @override
  String get tableName => DatabaseSchema.inventoryMovementsTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: movement.id,
      DatabaseSchema.organizationId: movement.organizationId,
      'branch_id': movement.branchId,
      'product_id': movement.productId,
      'movement_type': movement.movementType.name,
      'quantity': movement.quantity,
      'unit_cost': movement.unitCost,
      'reference_type': movement.referenceType?.name,
      'reference_id': movement.referenceId,
      'batch_id': movement.batchId,
      'serial_number': movement.serialNumber,
      'from_location': movement.fromLocation,
      'to_location': movement.toLocation,
      'notes': movement.notes,
      'performed_by': movement.performedBy,
      DatabaseSchema.metadata: encodeMetadata(movement.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(movement.createdAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(movement.syncedAt),
    };
  }
  
  /// Create InventoryMovement from database map
  factory InventoryMovementModel.fromDatabase(Map<String, dynamic> map) {
    final movement = _fromMap(map);
    return InventoryMovementModel(movement);
  }
  
  static InventoryMovement _fromMap(Map<String, dynamic> map) {
    return InventoryMovement(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      branchId: map['branch_id'] as String,
      productId: map['product_id'] as String,
      movementType: _parseMovementType(map['movement_type'] as String),
      quantity: (map['quantity'] as num).toDouble(),
      unitCost: (map['unit_cost'] as num?)?.toDouble(),
      referenceType: _parseReferenceType(map['reference_type'] as String?),
      referenceId: map['reference_id'] as String?,
      batchId: map['batch_id'] as String?,
      serialNumber: map['serial_number'] as String?,
      fromLocation: map['from_location'] as String?,
      toLocation: map['to_location'] as String?,
      notes: map['notes'] as String?,
      performedBy: map['performed_by'] as String?,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static MovementType _parseMovementType(String type) {
    try {
      return MovementType.values.firstWhere((e) => e.name == type);
    } catch (_) {
      return MovementType.adjustment;
    }
  }
  
  static ReferenceType? _parseReferenceType(String? type) {
    if (type == null) return null;
    try {
      return ReferenceType.values.firstWhere((e) => e.name == type);
    } catch (_) {
      return null;
    }
  }
  
  static Map<String, dynamic> _decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(json.decode(metadata));
    } catch (_) {
      return {};
    }
  }
}