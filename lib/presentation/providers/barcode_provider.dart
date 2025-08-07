import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/barcode/barcode_scanner_service.dart';

final barcodeScannerProvider = Provider<BarcodeScannerService>((ref) {
  return BarcodeScannerServiceFactory.create();
});