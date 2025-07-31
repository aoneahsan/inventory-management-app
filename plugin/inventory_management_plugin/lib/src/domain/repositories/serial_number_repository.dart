import '../entities/serial_number.dart';

abstract class SerialNumberRepository {
  Future<SerialNumber> create(SerialNumber serialNumber);
  Future<SerialNumber?> getById(String id);
  Future<SerialNumber?> getBySerialNumber(String serialNumber);
  Future<List<SerialNumber>> getByProductId(String productId);
  Future<List<SerialNumber>> getByBatchId(String batchId);
  Future<List<SerialNumber>> getAvailable(String productId, {String? branchId});
  Future<SerialNumber> update(SerialNumber serialNumber);
  Future<void> delete(String id);
  Future<List<SerialNumber>> getAll();
  Stream<List<SerialNumber>> watchByProduct(String productId);
  Stream<List<SerialNumber>> watchAvailable(String productId, {String? branchId});
  Future<void> markAsSold(String serialNumber, String saleId);
  Future<void> markAsReturned(String serialNumber);
  Future<List<SerialNumber>> searchSerialNumbers(String query);
}