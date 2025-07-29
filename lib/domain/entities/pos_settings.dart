class POSSettings {
  final String id;
  final String organizationId;
  final String? defaultRegisterId;
  final String receiptTemplate;
  final bool taxInclusive;
  final bool enableCustomerDisplay;
  final bool enableQuickKeys;
  final List<QuickKey>? quickKeys;
  final List<String> paymentMethods;
  final bool printReceiptDefault;
  final bool emailReceiptDefault;
  final bool barcodeScanningEnabled;
  final bool offlineModeEnabled;
  final int syncInterval;
  final String currency;
  final int decimalPlaces;
  final DateTime createdAt;
  final DateTime updatedAt;

  const POSSettings({
    required this.id,
    required this.organizationId,
    this.defaultRegisterId,
    this.receiptTemplate = ReceiptTemplate.defaultTemplate,
    this.taxInclusive = false,
    this.enableCustomerDisplay = true,
    this.enableQuickKeys = true,
    this.quickKeys,
    this.paymentMethods = const ['cash', 'card', 'upi'],
    this.printReceiptDefault = true,
    this.emailReceiptDefault = false,
    this.barcodeScanningEnabled = true,
    this.offlineModeEnabled = true,
    this.syncInterval = 30,
    this.currency = 'USD',
    this.decimalPlaces = 2,
    required this.createdAt,
    required this.updatedAt,
  });

  POSSettings copyWith({
    String? id,
    String? organizationId,
    String? defaultRegisterId,
    String? receiptTemplate,
    bool? taxInclusive,
    bool? enableCustomerDisplay,
    bool? enableQuickKeys,
    List<QuickKey>? quickKeys,
    List<String>? paymentMethods,
    bool? printReceiptDefault,
    bool? emailReceiptDefault,
    bool? barcodeScanningEnabled,
    bool? offlineModeEnabled,
    int? syncInterval,
    String? currency,
    int? decimalPlaces,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return POSSettings(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      defaultRegisterId: defaultRegisterId ?? this.defaultRegisterId,
      receiptTemplate: receiptTemplate ?? this.receiptTemplate,
      taxInclusive: taxInclusive ?? this.taxInclusive,
      enableCustomerDisplay: enableCustomerDisplay ?? this.enableCustomerDisplay,
      enableQuickKeys: enableQuickKeys ?? this.enableQuickKeys,
      quickKeys: quickKeys ?? this.quickKeys,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      printReceiptDefault: printReceiptDefault ?? this.printReceiptDefault,
      emailReceiptDefault: emailReceiptDefault ?? this.emailReceiptDefault,
      barcodeScanningEnabled: barcodeScanningEnabled ?? this.barcodeScanningEnabled,
      offlineModeEnabled: offlineModeEnabled ?? this.offlineModeEnabled,
      syncInterval: syncInterval ?? this.syncInterval,
      currency: currency ?? this.currency,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'defaultRegisterId': defaultRegisterId,
      'receiptTemplate': receiptTemplate,
      'taxInclusive': taxInclusive,
      'enableCustomerDisplay': enableCustomerDisplay,
      'enableQuickKeys': enableQuickKeys,
      'quickKeys': quickKeys?.map((key) => key.toJson()).toList(),
      'paymentMethods': paymentMethods,
      'printReceiptDefault': printReceiptDefault,
      'emailReceiptDefault': emailReceiptDefault,
      'barcodeScanningEnabled': barcodeScanningEnabled,
      'offlineModeEnabled': offlineModeEnabled,
      'syncInterval': syncInterval,
      'currency': currency,
      'decimalPlaces': decimalPlaces,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory POSSettings.fromJson(Map<String, dynamic> json) {
    return POSSettings(
      id: json['id'],
      organizationId: json['organizationId'],
      defaultRegisterId: json['defaultRegisterId'],
      receiptTemplate: json['receiptTemplate'] ?? ReceiptTemplate.defaultTemplate,
      taxInclusive: json['taxInclusive'] ?? false,
      enableCustomerDisplay: json['enableCustomerDisplay'] ?? true,
      enableQuickKeys: json['enableQuickKeys'] ?? true,
      quickKeys: json['quickKeys'] != null
          ? (json['quickKeys'] as List<dynamic>)
              .map((key) => QuickKey.fromJson(key))
              .toList()
          : null,
      paymentMethods: json['paymentMethods'] != null
          ? List<String>.from(json['paymentMethods'])
          : const ['cash', 'card', 'upi'],
      printReceiptDefault: json['printReceiptDefault'] ?? true,
      emailReceiptDefault: json['emailReceiptDefault'] ?? false,
      barcodeScanningEnabled: json['barcodeScanningEnabled'] ?? true,
      offlineModeEnabled: json['offlineModeEnabled'] ?? true,
      syncInterval: json['syncInterval'] ?? 30,
      currency: json['currency'] ?? 'USD',
      decimalPlaces: json['decimalPlaces'] ?? 2,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory POSSettings.defaultSettings(String organizationId) {
    final now = DateTime.now();
    return POSSettings(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      organizationId: organizationId,
      createdAt: now,
      updatedAt: now,
    );
  }
}

class QuickKey {
  final String id;
  final String productId;
  final String label;
  final String? color;
  final int position;

  const QuickKey({
    required this.id,
    required this.productId,
    required this.label,
    this.color,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'label': label,
      'color': color,
      'position': position,
    };
  }

  factory QuickKey.fromJson(Map<String, dynamic> json) {
    return QuickKey(
      id: json['id'],
      productId: json['productId'],
      label: json['label'],
      color: json['color'],
      position: json['position'],
    );
  }
}

class PaymentMethod {
  static const String cash = 'cash';
  static const String card = 'card';
  static const String upi = 'upi';
  static const String wallet = 'wallet';
  static const String credit = 'credit';
  static const String split = 'split';
}

class SaleStatus {
  static const String pending = 'pending';
  static const String completed = 'completed';
  static const String refunded = 'refunded';
  static const String partialRefund = 'partial_refund';
  static const String cancelled = 'cancelled';
}