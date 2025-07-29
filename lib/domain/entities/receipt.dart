class Receipt {
  final String id;
  final String saleId;
  final String receiptNumber;
  final String template;
  final Map<String, dynamic>? customFields;
  final String format;
  final bool isPrinted;
  final DateTime? printedAt;
  final String? printerName;
  final String? digitalReceipt;
  final DateTime createdAt;

  const Receipt({
    required this.id,
    required this.saleId,
    required this.receiptNumber,
    required this.template,
    this.customFields,
    required this.format,
    this.isPrinted = false,
    this.printedAt,
    this.printerName,
    this.digitalReceipt,
    required this.createdAt,
  });

  Receipt copyWith({
    String? id,
    String? saleId,
    String? receiptNumber,
    String? template,
    Map<String, dynamic>? customFields,
    String? format,
    bool? isPrinted,
    DateTime? printedAt,
    String? printerName,
    String? digitalReceipt,
    DateTime? createdAt,
  }) {
    return Receipt(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      template: template ?? this.template,
      customFields: customFields ?? this.customFields,
      format: format ?? this.format,
      isPrinted: isPrinted ?? this.isPrinted,
      printedAt: printedAt ?? this.printedAt,
      printerName: printerName ?? this.printerName,
      digitalReceipt: digitalReceipt ?? this.digitalReceipt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'saleId': saleId,
      'receiptNumber': receiptNumber,
      'template': template,
      'customFields': customFields,
      'format': format,
      'isPrinted': isPrinted,
      'printedAt': printedAt?.toIso8601String(),
      'printerName': printerName,
      'digitalReceipt': digitalReceipt,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      id: json['id'],
      saleId: json['saleId'],
      receiptNumber: json['receiptNumber'],
      template: json['template'],
      customFields: json['customFields'] != null
          ? Map<String, dynamic>.from(json['customFields'])
          : null,
      format: json['format'],
      isPrinted: json['isPrinted'] ?? false,
      printedAt: json['printedAt'] != null 
          ? DateTime.parse(json['printedAt']) 
          : null,
      printerName: json['printerName'],
      digitalReceipt: json['digitalReceipt'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ReceiptTemplate {
  static const String defaultTemplate = 'default';
  static const String minimal = 'minimal';
  static const String detailed = 'detailed';
  static const String custom = 'custom';
}

class ReceiptFormat {
  static const String pdf = 'pdf';
  static const String thermal = 'thermal';
  static const String a4 = 'a4';
  static const String email = 'email';
}

class DigitalReceiptType {
  static const String email = 'email';
  static const String whatsapp = 'whatsapp';
  static const String sms = 'sms';
}