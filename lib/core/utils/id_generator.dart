import 'dart:math';

class IdGenerator {
  static final _random = Random();
  static const _chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  
  static String generateId({String prefix = '', int length = 8}) {
    return generateUniqueId(prefix: prefix, length: length);
  }
  
  static String generateUniqueId({String prefix = '', int length = 8}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final random = generateRandomString(length);
    
    if (prefix.isNotEmpty) {
      return '${prefix}_${timestamp}_$random';
    }
    return '${timestamp}_$random';
  }
  
  static String generateRandomString(int length) {
    return List.generate(
      length,
      (_) => _chars[_random.nextInt(_chars.length)],
    ).join();
  }
  
  static String generateOrderNumber({String prefix = 'ORD'}) {
    final date = DateTime.now();
    final year = date.year.toString().substring(2);
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final random = generateRandomString(4).toUpperCase();
    
    return '$prefix-$year$month$day-$random';
  }
  
  static String generateInvoiceNumber({String prefix = 'INV'}) {
    final date = DateTime.now();
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final sequence = generateRandomString(4).toUpperCase();
    
    return '$prefix-$year$month-$sequence';
  }
  
  static String generatePONumber({String prefix = 'PO'}) {
    final date = DateTime.now();
    final year = date.year.toString().substring(2);
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final random = generateRandomString(4).toUpperCase();
    
    return '$prefix-$year$month$day-$random';
  }
  
  static String generateProductCode({String? category}) {
    final prefix = category?.substring(0, 3).toUpperCase() ?? 'PRD';
    final random = generateRandomString(6).toUpperCase();
    
    return '$prefix-$random';
  }
  
  static String generateBatchNumber() {
    final date = DateTime.now();
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final random = generateRandomString(4).toUpperCase();
    
    return 'B$year$month$day$random';
  }
  
  static String generateSerialNumber({String? prefix}) {
    final prefixStr = prefix ?? 'SN';
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(4);
    final random = generateRandomString(4).toUpperCase();
    
    return '$prefixStr$timestamp$random';
  }
}