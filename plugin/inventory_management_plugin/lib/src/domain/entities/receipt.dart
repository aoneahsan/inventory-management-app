import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt.freezed.dart';
part 'receipt.g.dart';

@freezed
class Receipt with _$Receipt {
  const factory Receipt({
    required String id,
    required String saleId,
    required String receiptNumber,
    @Default('default') String template,
    @Default({}) Map<String, dynamic> customFields,
    @Default('thermal') String format,
    @Default(false) bool isPrinted,
    DateTime? printedAt,
    String? printerName,
    String? digitalReceipt,
    required DateTime createdAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? organizationId,
    String? branchId,
    String? registerId,
    String? cashierId,
    @Default({}) Map<String, dynamic> metadata,
    String? qrCode,
    String? barcode,
    @Default(false) bool isReprint,
    int? reprintCount,
    String? reprintReason,
    DateTime? emailedAt,
    String? emailedTo,
    DateTime? smsAt,
    String? smsTo,
    String? signatureUrl,
    @Default({}) Map<String, dynamic> headerData,
    @Default({}) Map<String, dynamic> footerData,
  }) = _Receipt;
  
  const Receipt._();
  
  factory Receipt.fromJson(Map<String, dynamic> json) => 
      _$ReceiptFromJson(json);
  
  // Helper methods
  bool get hasBeenSent => emailedAt != null || smsAt != null;
  bool get needsSignature => signatureUrl == null && format == 'a4';
  
  String get statusDisplayName {
    if (isPrinted && hasBeenSent) return 'Printed & Sent';
    if (isPrinted) return 'Printed';
    if (hasBeenSent) return 'Sent';
    return 'Pending';
  }
  
  String generateReceiptContent({
    required Map<String, dynamic> saleData,
    required Map<String, dynamic> organizationData,
    required List<Map<String, dynamic>> items,
  }) {
    // This would generate the actual receipt content based on template
    return '''
=================================
${organizationData['name']}
${organizationData['address']}
Tel: ${organizationData['phone']}
=================================
Receipt #: $receiptNumber
Date: ${createdAt.toString()}
Cashier: ${cashierId ?? 'N/A'}
---------------------------------
ITEMS:
${items.map((item) => '${item['name']} x${item['quantity']} = ${item['total']}').join('\n')}
---------------------------------
Subtotal: ${saleData['subtotal']}
Tax: ${saleData['tax']}
Total: ${saleData['total']}
=================================
Thank you for your purchase!
=================================
    ''';
  }
}

class ReceiptTemplate {
  static const String defaultTemplate = 'default';
  static const String minimal = 'minimal';
  static const String detailed = 'detailed';
  static const String custom = 'custom';
  static const String invoice = 'invoice';
  static const String kitchenOrder = 'kitchen_order';
  
  static String getDisplayName(String template) {
    switch (template) {
      case defaultTemplate:
        return 'Default';
      case minimal:
        return 'Minimal';
      case detailed:
        return 'Detailed';
      case custom:
        return 'Custom';
      case invoice:
        return 'Invoice';
      case kitchenOrder:
        return 'Kitchen Order';
      default:
        return template;
    }
  }
}

class ReceiptFormat {
  static const String pdf = 'pdf';
  static const String thermal = 'thermal';
  static const String a4 = 'a4';
  static const String email = 'email';
  static const String pos80mm = 'pos80mm';
  static const String pos58mm = 'pos58mm';
  
  static String getDisplayName(String format) {
    switch (format) {
      case pdf:
        return 'PDF';
      case thermal:
        return 'Thermal';
      case a4:
        return 'A4';
      case email:
        return 'Email';
      case pos80mm:
        return '80mm POS';
      case pos58mm:
        return '58mm POS';
      default:
        return format;
    }
  }
}

class DigitalReceiptType {
  static const String email = 'email';
  static const String whatsapp = 'whatsapp';
  static const String sms = 'sms';
  static const String qrCode = 'qr_code';
  
  static String getDisplayName(String type) {
    switch (type) {
      case email:
        return 'Email';
      case whatsapp:
        return 'WhatsApp';
      case sms:
        return 'SMS';
      case qrCode:
        return 'QR Code';
      default:
        return type;
    }
  }
}