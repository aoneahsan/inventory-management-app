import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_rate.freezed.dart';
part 'tax_rate.g.dart';

enum TaxType {
  @JsonValue('GST')
  gst,
  @JsonValue('VAT')
  vat,
  @JsonValue('Sales Tax')
  salesTax,
  @JsonValue('Service Tax')
  serviceTax,
  @JsonValue('Excise')
  excise,
  @JsonValue('Custom Duty')
  customDuty,
  @JsonValue('Other')
  other,
}

@freezed
class TaxRate with _$TaxRate {
  const factory TaxRate({
    required String id,
    required String organizationId,
    required String name,
    required String code,
    required double rate,
    required TaxType type,
    @Default(false) bool isCompound,
    @Default(false) bool isInclusive,
    @Default(true) bool isActive,
    double? cgstRate,
    double? sgstRate,
    double? igstRate,
    double? cessRate,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? description,
    @Default([]) List<String> applicableToCategories,
    @Default([]) List<String> applicableToProducts,
    DateTime? effectiveFrom,
    DateTime? effectiveTo,
    @Default({}) Map<String, dynamic> metadata,
    @Default(0) int priority,
    String? parentTaxId,
    @Default(false) bool isDefault,
  }) = _TaxRate;
  
  const TaxRate._();
  
  factory TaxRate.fromJson(Map<String, dynamic> json) => 
      _$TaxRateFromJson(json);
  
  // Helper methods
  double calculateTax(double amount, {double? previousTax}) {
    double baseAmount = amount;
    if (isCompound && previousTax != null) {
      baseAmount += previousTax;
    }
    return baseAmount * (rate / 100);
  }
  
  double calculateGSTComponents(double amount, {bool isInterState = false}) {
    if (type != TaxType.gst) return calculateTax(amount);
    
    if (isInterState && igstRate != null) {
      return amount * (igstRate! / 100);
    } else if (!isInterState && cgstRate != null && sgstRate != null) {
      final cgst = amount * (cgstRate! / 100);
      final sgst = amount * (sgstRate! / 100);
      final cess = cessRate != null ? amount * (cessRate! / 100) : 0;
      return cgst + sgst + cess;
    }
    
    return calculateTax(amount);
  }
  
  double calculateInclusiveAmount(double totalAmount) {
    if (!isInclusive) return totalAmount;
    return totalAmount / (1 + (rate / 100));
  }
  
  double extractTaxFromInclusiveAmount(double inclusiveAmount) {
    if (!isInclusive) return 0;
    final baseAmount = inclusiveAmount / (1 + (rate / 100));
    return inclusiveAmount - baseAmount;
  }
  
  bool get isGST => type == TaxType.gst;
  bool get hasGSTComponents => isGST && (cgstRate != null || sgstRate != null || igstRate != null);
  
  bool get isEffective {
    final now = DateTime.now();
    final isAfterStart = effectiveFrom == null || now.isAfter(effectiveFrom!);
    final isBeforeEnd = effectiveTo == null || now.isBefore(effectiveTo!);
    return isActive && isAfterStart && isBeforeEnd;
  }
  
  String get displayName {
    if (isGST && hasGSTComponents) {
      if (igstRate != null) {
        return '$name (IGST: $igstRate%)';
      } else if (cgstRate != null && sgstRate != null) {
        return '$name (CGST: $cgstRate% + SGST: $sgstRate%)';
      }
    }
    return '$name ($rate%)';
  }
  
  String get typeDisplayName {
    switch (type) {
      case TaxType.gst:
        return 'GST';
      case TaxType.vat:
        return 'VAT';
      case TaxType.salesTax:
        return 'Sales Tax';
      case TaxType.serviceTax:
        return 'Service Tax';
      case TaxType.excise:
        return 'Excise';
      case TaxType.customDuty:
        return 'Custom Duty';
      case TaxType.other:
        return 'Other';
    }
  }
}

@freezed
class HsnCode with _$HsnCode {
  const factory HsnCode({
    required String id,
    required String organizationId,
    required String code,
    String? description,
    String? taxRateId,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? chapter,
    String? section,
    @Default({}) Map<String, dynamic> metadata,
    @Default(true) bool isActive,
  }) = _HsnCode;
  
  const HsnCode._();
  
  factory HsnCode.fromJson(Map<String, dynamic> json) => 
      _$HsnCodeFromJson(json);
  
  // Helper methods
  String get formattedCode {
    if (code.length >= 4) {
      return '${code.substring(0, 4)} ${code.substring(4)}';
    }
    return code;
  }
  
  bool get isServiceCode => code.startsWith('99');
}