import 'dart:async';
import 'dart:typed_data';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_widget/barcode_widget.dart' as bw;
import '../../domain/entities/product.dart';
import '../../domain/entities/batch.dart';
import '../../domain/entities/serial_number.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/batch_repository.dart';
import '../../domain/repositories/serial_number_repository.dart';
import '../../core/utils/logger.dart';

/// Service for barcode generation and parsing
class BarcodeService {
  final ProductRepository _productRepository;
  final BatchRepository _batchRepository;
  final SerialNumberRepository _serialNumberRepository;

  // Barcode prefixes for different types
  static const String productPrefix = 'PRD';
  static const String batchPrefix = 'BTH';
  static const String serialPrefix = 'SRL';
  static const String customPrefix = 'CST';

  BarcodeService({
    required ProductRepository productRepository,
    required BatchRepository batchRepository,
    required SerialNumberRepository serialNumberRepository,
  })  : _productRepository = productRepository,
        _batchRepository = batchRepository,
        _serialNumberRepository = serialNumberRepository;

  /// Generates barcode data for a product
  String generateProductBarcode(Product product) {
    // Format: PRD-{SKU} or PRD-{ID} if no SKU
    final identifier = product.sku ?? product.id;
    return '$productPrefix-$identifier';
  }

  /// Generates barcode data for a batch
  String generateBatchBarcode(Batch batch) {
    // Format: BTH-{BATCH_NUMBER}
    return '$batchPrefix-${batch.batchNumber}';
  }

  /// Generates barcode data for a serial number
  String generateSerialBarcode(SerialNumber serial) {
    // Format: SRL-{SERIAL_NUMBER}
    return '$serialPrefix-${serial.serialNumber}';
  }

  /// Generates custom barcode data
  String generateCustomBarcode({
    required String type,
    required String identifier,
    Map<String, String>? additionalData,
  }) {
    // Format: CST-{TYPE}-{IDENTIFIER}[-{DATA}]
    var barcode = '$customPrefix-$type-$identifier';
    
    if (additionalData != null && additionalData.isNotEmpty) {
      final dataString = additionalData.entries
          .map((e) => '${e.key}:${e.value}')
          .join(',');
      barcode += '-$dataString';
    }
    
    return barcode;
  }

  /// Parses barcode data and returns entity information
  Future<BarcodeParseResult?> parseBarcode(String barcodeData) async {
    try {
      if (barcodeData.isEmpty) {
        throw Exception('Empty barcode data');
      }

      final parts = barcodeData.split('-');
      if (parts.isEmpty) {
        throw Exception('Invalid barcode format');
      }

      final prefix = parts[0];
      
      switch (prefix) {
        case productPrefix:
          return await _parseProductBarcode(parts);
        case batchPrefix:
          return await _parseBatchBarcode(parts);
        case serialPrefix:
          return await _parseSerialBarcode(parts);
        case customPrefix:
          return _parseCustomBarcode(parts);
        default:
          // Try to find product by SKU or barcode directly
          return await _findProductByBarcode(barcodeData);
      }
    } catch (e) {
      Logger.error('Error parsing barcode: $e');
      return null;
    }
  }

  /// Generates QR code image
  Future<Uint8List> generateQRCode({
    required String data,
    int size = 200,
    int errorCorrectionLevel = QrErrorCorrectLevel.M,
  }) async {
    try {
      final qrPainter = QrPainter(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: errorCorrectionLevel,
        gapless: true,
        emptyColor: const Color(0xFFFFFFFF),
        color: const Color(0xFF000000),
      );

      final picData = await qrPainter.toImageData(size.toDouble());
      return picData!.buffer.asUint8List();
    } catch (e) {
      Logger.error('Error generating QR code: $e');
      rethrow;
    }
  }

  /// Generates standard barcode image
  Future<Uint8List> generateBarcode({
    required String data,
    bw.Barcode type = bw.Barcode.code128(),
    double width = 300,
    double height = 100,
    bool showText = true,
  }) async {
    try {
      final widget = bw.BarcodeWidget(
        barcode: type,
        data: data,
        width: width,
        height: height,
        drawText: showText,
      );

      // Convert widget to image
      // This would need platform-specific implementation
      // For now, returning empty data
      return Uint8List(0);
    } catch (e) {
      Logger.error('Error generating barcode: $e');
      rethrow;
    }
  }

  /// Generates product label with barcode
  Future<ProductLabel> generateProductLabel({
    required Product product,
    bool includePrice = true,
    bool includeQR = false,
    Map<String, String>? customFields,
  }) async {
    try {
      final barcodeData = generateProductBarcode(product);
      
      Uint8List? barcodeImage;
      Uint8List? qrImage;

      // Generate barcode image
      barcodeImage = await generateBarcode(data: barcodeData);

      // Generate QR code if requested
      if (includeQR) {
        qrImage = await generateQRCode(data: barcodeData);
      }

      return ProductLabel(
        product: product,
        barcodeData: barcodeData,
        barcodeImage: barcodeImage,
        qrImage: qrImage,
        includePrice: includePrice,
        customFields: customFields,
      );
    } catch (e) {
      Logger.error('Error generating product label: $e');
      rethrow;
    }
  }

  /// Batch generates barcodes for multiple products
  Future<List<ProductLabel>> batchGenerateLabels({
    required List<Product> products,
    bool includePrice = true,
    bool includeQR = false,
  }) async {
    try {
      final labels = <ProductLabel>[];

      for (final product in products) {
        final label = await generateProductLabel(
          product: product,
          includePrice: includePrice,
          includeQR: includeQR,
        );
        labels.add(label);
      }

      return labels;
    } catch (e) {
      Logger.error('Error batch generating labels: $e');
      rethrow;
    }
  }

  /// Validates barcode format
  bool isValidBarcode(String barcode) {
    if (barcode.isEmpty) return false;
    
    // Check for supported prefixes
    if (barcode.startsWith(productPrefix) ||
        barcode.startsWith(batchPrefix) ||
        barcode.startsWith(serialPrefix) ||
        barcode.startsWith(customPrefix)) {
      return barcode.split('-').length >= 2;
    }

    // Allow any non-empty barcode for product lookup
    return true;
  }

  // Private helper methods

  Future<BarcodeParseResult?> _parseProductBarcode(List<String> parts) async {
    if (parts.length < 2) return null;
    
    final identifier = parts.sublist(1).join('-');
    
    // Try to find by SKU first
    final products = await _productRepository.getAllProducts();
    var product = products.firstWhere(
      (p) => p.sku == identifier,
      orElse: () => Product(
        id: '', 
        organizationId: '', 
        name: '', 
        categoryId: '', 
        unit: '', 
        trackInventory: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        syncStatus: '',
      ),
    );

    // If not found by SKU, try by ID
    if (product.id.isEmpty) {
      final found = await _productRepository.getProductById(identifier);
      if (found != null) product = found;
    }

    if (product.id.isNotEmpty) {
      return BarcodeParseResult(
        type: BarcodeType.product,
        product: product,
        rawData: parts.join('-'),
      );
    }

    return null;
  }

  Future<BarcodeParseResult?> _parseBatchBarcode(List<String> parts) async {
    if (parts.length < 2) return null;
    
    final batchNumber = parts.sublist(1).join('-');
    final batch = await _batchRepository.getBatchByNumber(batchNumber);

    if (batch != null) {
      return BarcodeParseResult(
        type: BarcodeType.batch,
        batch: batch,
        rawData: parts.join('-'),
      );
    }

    return null;
  }

  Future<BarcodeParseResult?> _parseSerialBarcode(List<String> parts) async {
    if (parts.length < 2) return null;
    
    final serialNumber = parts.sublist(1).join('-');
    final serial = await _serialNumberRepository.getBySerialNumber(serialNumber);

    if (serial != null) {
      return BarcodeParseResult(
        type: BarcodeType.serial,
        serialNumber: serial,
        rawData: parts.join('-'),
      );
    }

    return null;
  }

  BarcodeParseResult? _parseCustomBarcode(List<String> parts) {
    if (parts.length < 3) return null;

    final type = parts[1];
    final identifier = parts[2];
    
    Map<String, String>? additionalData;
    if (parts.length > 3) {
      additionalData = {};
      final dataString = parts.sublist(3).join('-');
      final dataParts = dataString.split(',');
      
      for (final part in dataParts) {
        final keyValue = part.split(':');
        if (keyValue.length == 2) {
          additionalData[keyValue[0]] = keyValue[1];
        }
      }
    }

    return BarcodeParseResult(
      type: BarcodeType.custom,
      customType: type,
      customIdentifier: identifier,
      customData: additionalData,
      rawData: parts.join('-'),
    );
  }

  Future<BarcodeParseResult?> _findProductByBarcode(String barcode) async {
    final products = await _productRepository.getAllProducts();
    final product = products.firstWhere(
      (p) => p.barcode == barcode || p.sku == barcode,
      orElse: () => Product(
        id: '', 
        organizationId: '', 
        name: '', 
        categoryId: '', 
        unit: '', 
        trackInventory: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        syncStatus: '',
      ),
    );

    if (product.id.isNotEmpty) {
      return BarcodeParseResult(
        type: BarcodeType.product,
        product: product,
        rawData: barcode,
      );
    }

    return null;
  }

  void dispose() {
    _productRepository.dispose();
    _batchRepository.dispose();
    _serialNumberRepository.dispose();
  }
}

// Supporting classes

enum BarcodeType {
  product,
  batch,
  serial,
  custom,
}

class BarcodeParseResult {
  final BarcodeType type;
  final Product? product;
  final Batch? batch;
  final SerialNumber? serialNumber;
  final String? customType;
  final String? customIdentifier;
  final Map<String, String>? customData;
  final String rawData;

  BarcodeParseResult({
    required this.type,
    this.product,
    this.batch,
    this.serialNumber,
    this.customType,
    this.customIdentifier,
    this.customData,
    required this.rawData,
  });
}

class ProductLabel {
  final Product product;
  final String barcodeData;
  final Uint8List? barcodeImage;
  final Uint8List? qrImage;
  final bool includePrice;
  final Map<String, String>? customFields;

  ProductLabel({
    required this.product,
    required this.barcodeData,
    this.barcodeImage,
    this.qrImage,
    required this.includePrice,
    this.customFields,
  });
}