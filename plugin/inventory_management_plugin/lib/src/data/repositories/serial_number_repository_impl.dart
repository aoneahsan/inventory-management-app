import 'package:drift/drift.dart';
import '../../domain/entities/serial_number.dart';
import '../../domain/repositories/serial_number_repository.dart';
import '../database/app_database.dart';

class SerialNumberRepositoryImpl implements SerialNumberRepository {
  final AppDatabase _database;

  SerialNumberRepositoryImpl(this._database);

  @override
  Future<SerialNumber> create(SerialNumber serialNumber) async {
    final companion = SerialNumbersCompanion(
      id: Value(serialNumber.id),
      serialNumber: Value(serialNumber.serialNumber),
      productId: Value(serialNumber.productId),
      batchId: Value.ofNullable(serialNumber.batchId),
      branchId: Value.ofNullable(serialNumber.branchId),
      status: Value(serialNumber.status.name),
      purchaseDate: Value(serialNumber.purchaseDate),
      soldDate: Value.ofNullable(serialNumber.soldDate),
      saleId: Value.ofNullable(serialNumber.saleId),
      warrantyExpiry: Value.ofNullable(serialNumber.warrantyExpiry),
      notes: Value.ofNullable(serialNumber.notes),
      metadata: Value(serialNumber.metadata ?? {}),
      createdAt: Value(serialNumber.createdAt),
      updatedAt: Value(serialNumber.updatedAt),
      syncStatus: const Value('pending'),
    );

    await _database.into(_database.serialNumbers).insert(companion);
    return serialNumber;
  }

  @override
  Future<SerialNumber?> getById(String id) async {
    final query = _database.select(_database.serialNumbers)
      ..where((s) => s.id.equals(id));
    
    final result = await query.getSingleOrNull();
    return result != null ? _convertToEntity(result) : null;
  }

  @override
  Future<SerialNumber?> getBySerialNumber(String serialNumber) async {
    final query = _database.select(_database.serialNumbers)
      ..where((s) => s.serialNumber.equals(serialNumber));
    
    final result = await query.getSingleOrNull();
    return result != null ? _convertToEntity(result) : null;
  }

  @override
  Future<List<SerialNumber>> getByProductId(String productId) async {
    final query = _database.select(_database.serialNumbers)
      ..where((s) => s.productId.equals(productId))
      ..orderBy([
        (s) => OrderingTerm(expression: s.createdAt, mode: OrderingMode.desc),
      ]);
    
    final results = await query.get();
    return results.map((s) => _convertToEntity(s)).toList();
  }

  @override
  Future<List<SerialNumber>> getByBatchId(String batchId) async {
    final query = _database.select(_database.serialNumbers)
      ..where((s) => s.batchId.equals(batchId))
      ..orderBy([
        (s) => OrderingTerm(expression: s.serialNumber),
      ]);
    
    final results = await query.get();
    return results.map((s) => _convertToEntity(s)).toList();
  }

  @override
  Future<List<SerialNumber>> getAvailable(String productId, {String? branchId}) async {
    final query = _database.select(_database.serialNumbers)
      ..where((s) => s.productId.equals(productId) & s.status.equals('available'));
    
    if (branchId != null) {
      query.where((s) => s.branchId.equals(branchId));
    }
    
    query.orderBy([
      (s) => OrderingTerm(expression: s.purchaseDate),
    ]);
    
    final results = await query.get();
    return results.map((s) => _convertToEntity(s)).toList();
  }

  @override
  Future<SerialNumber> update(SerialNumber serialNumber) async {
    final companion = SerialNumbersCompanion(
      serialNumber: Value(serialNumber.serialNumber),
      productId: Value(serialNumber.productId),
      batchId: Value.ofNullable(serialNumber.batchId),
      branchId: Value.ofNullable(serialNumber.branchId),
      status: Value(serialNumber.status.name),
      purchaseDate: Value(serialNumber.purchaseDate),
      soldDate: Value.ofNullable(serialNumber.soldDate),
      saleId: Value.ofNullable(serialNumber.saleId),
      warrantyExpiry: Value.ofNullable(serialNumber.warrantyExpiry),
      notes: Value.ofNullable(serialNumber.notes),
      metadata: Value(serialNumber.metadata ?? {}),
      updatedAt: Value(DateTime.now()),
      syncStatus: const Value('pending'),
    );

    await (_database.update(_database.serialNumbers)
      ..where((s) => s.id.equals(serialNumber.id)))
      .write(companion);
    
    return serialNumber.copyWith(updatedAt: DateTime.now());
  }

  @override
  Future<void> delete(String id) async {
    await (_database.delete(_database.serialNumbers)
      ..where((s) => s.id.equals(id)))
      .go();
  }

  @override
  Future<List<SerialNumber>> getAll() async {
    final query = _database.select(_database.serialNumbers)
      ..orderBy([
        (s) => OrderingTerm(expression: s.createdAt, mode: OrderingMode.desc),
      ]);
    
    final results = await query.get();
    return results.map((s) => _convertToEntity(s)).toList();
  }

  @override
  Stream<List<SerialNumber>> watchByProduct(String productId) {
    final query = _database.select(_database.serialNumbers)
      ..where((s) => s.productId.equals(productId))
      ..orderBy([
        (s) => OrderingTerm(expression: s.serialNumber),
      ]);
    
    return query.watch().map((results) => 
      results.map((s) => _convertToEntity(s)).toList()
    );
  }

  @override
  Stream<List<SerialNumber>> watchAvailable(String productId, {String? branchId}) {
    final query = _database.select(_database.serialNumbers)
      ..where((s) => s.productId.equals(productId) & s.status.equals('available'));
    
    if (branchId != null) {
      query.where((s) => s.branchId.equals(branchId));
    }
    
    query.orderBy([
      (s) => OrderingTerm(expression: s.purchaseDate),
    ]);
    
    return query.watch().map((results) => 
      results.map((s) => _convertToEntity(s)).toList()
    );
  }

  @override
  Future<void> markAsSold(String serialNumber, String saleId) async {
    final companion = SerialNumbersCompanion(
      status: const Value('sold'),
      soldDate: Value(DateTime.now()),
      saleId: Value(saleId),
      updatedAt: Value(DateTime.now()),
      syncStatus: const Value('pending'),
    );

    await (_database.update(_database.serialNumbers)
      ..where((s) => s.serialNumber.equals(serialNumber)))
      .write(companion);
  }

  @override
  Future<void> markAsReturned(String serialNumber) async {
    final companion = SerialNumbersCompanion(
      status: const Value('available'),
      soldDate: const Value.absent(),
      saleId: const Value.absent(),
      updatedAt: Value(DateTime.now()),
      syncStatus: const Value('pending'),
    );

    await (_database.update(_database.serialNumbers)
      ..where((s) => s.serialNumber.equals(serialNumber)))
      .write(companion);
  }

  @override
  Future<List<SerialNumber>> searchSerialNumbers(String query) async {
    final searchQuery = '%${query.toLowerCase()}%';
    
    final results = await _database.select(_database.serialNumbers)
      .where((s) => s.serialNumber.like(searchQuery))
      .get();
    
    return results.map((s) => _convertToEntity(s)).toList();
  }

  SerialNumber _convertToEntity(SerialNumberData data) {
    return SerialNumber(
      id: data.id,
      serialNumber: data.serialNumber,
      productId: data.productId,
      batchId: data.batchId,
      branchId: data.branchId,
      status: SerialNumberStatus.values.firstWhere(
        (s) => s.name == data.status,
        orElse: () => SerialNumberStatus.available,
      ),
      purchaseDate: data.purchaseDate,
      soldDate: data.soldDate,
      saleId: data.saleId,
      warrantyExpiry: data.warrantyExpiry,
      notes: data.notes,
      metadata: data.metadata,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}