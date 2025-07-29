import '../../domain/entities/product.dart';
import '../../domain/entities/sale.dart';
import '../../domain/entities/pos_settings.dart';

class TaxService {
  // Calculate tax for a product
  double calculateProductTax({
    required Product product,
    required double amount,
    required bool taxInclusive,
  }) {
    if (product.taxRate <= 0) return 0;

    if (taxInclusive) {
      // Tax is included in the price
      return amount - (amount / (1 + product.taxRate / 100));
    } else {
      // Tax is added to the price
      return amount * (product.taxRate / 100);
    }
  }

  // Calculate tax for multiple items
  Map<String, double> calculateSaleTax({
    required List<SaleItem> items,
    required bool taxInclusive,
  }) {
    final taxByRate = <String, double>{};
    double totalTax = 0;

    for (final item in items) {
      final taxAmount = taxInclusive
          ? item.totalAmount - (item.totalAmount / (1 + item.taxPercent / 100))
          : item.taxAmount;

      final rateKey = '${item.taxPercent}%';
      taxByRate[rateKey] = (taxByRate[rateKey] ?? 0) + taxAmount;
      totalTax += taxAmount;
    }

    taxByRate['total'] = totalTax;
    return taxByRate;
  }

  // GST calculation for India
  Map<String, double> calculateGST({
    required double amount,
    required double gstRate,
    required bool isInterstate,
    required bool taxInclusive,
  }) {
    double taxableAmount = amount;
    double totalGst = 0;

    if (taxInclusive) {
      taxableAmount = amount / (1 + gstRate / 100);
      totalGst = amount - taxableAmount;
    } else {
      totalGst = amount * (gstRate / 100);
    }

    if (isInterstate) {
      // IGST for interstate
      return {
        'taxableAmount': taxableAmount,
        'igst': totalGst,
        'cgst': 0,
        'sgst': 0,
        'totalTax': totalGst,
        'totalAmount': taxInclusive ? amount : amount + totalGst,
      };
    } else {
      // CGST + SGST for intrastate
      final halfGst = totalGst / 2;
      return {
        'taxableAmount': taxableAmount,
        'igst': 0,
        'cgst': halfGst,
        'sgst': halfGst,
        'totalTax': totalGst,
        'totalAmount': taxInclusive ? amount : amount + totalGst,
      };
    }
  }

  // Generate tax summary for a sale
  Map<String, dynamic> generateTaxSummary({
    required Sale sale,
    required POSSettings settings,
  }) {
    final taxByRate = calculateSaleTax(
      items: sale.items,
      taxInclusive: settings.taxInclusive,
    );

    return {
      'subtotal': sale.subtotal,
      'taxableAmount': settings.taxInclusive 
          ? sale.subtotal - sale.taxAmount 
          : sale.subtotal,
      'taxByRate': taxByRate,
      'totalTax': sale.taxAmount,
      'discount': sale.discountAmount,
      'total': sale.totalAmount,
      'taxInclusive': settings.taxInclusive,
    };
  }

  // Validate tax exemption
  bool isValidTaxExemption({
    required String? taxId,
    required String? exemptionCertificate,
  }) {
    if (taxId == null || exemptionCertificate == null) return false;
    
    // Basic validation - in production, this would verify against government database
    return taxId.isNotEmpty && exemptionCertificate.isNotEmpty;
  }

  // Calculate reverse charge mechanism (for B2B)
  Map<String, double> calculateReverseCharge({
    required double amount,
    required double taxRate,
    required bool taxInclusive,
  }) {
    double taxableAmount = amount;
    double taxAmount = 0;

    if (taxInclusive) {
      taxableAmount = amount / (1 + taxRate / 100);
      taxAmount = amount - taxableAmount;
    } else {
      taxAmount = amount * (taxRate / 100);
    }

    return {
      'taxableAmount': taxableAmount,
      'reverseChargeTax': taxAmount,
      'totalAmount': taxableAmount, // Buyer pays tax separately
    };
  }
}