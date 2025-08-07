import 'package:flutter/foundation.dart';

abstract class BarcodeScannerService {
  Future<String?> scanBarcode();
  bool get isSupported;
}

class BarcodeScannerServiceImpl implements BarcodeScannerService {
  @override
  bool get isSupported => !kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || 
                                       defaultTargetPlatform == TargetPlatform.android);
  
  @override
  Future<String?> scanBarcode() async {
    if (!isSupported) {
      throw UnsupportedError('Barcode scanning is not supported on this platform');
    }
    
    // For now, return null since mobile_scanner is disabled
    // When enabled, uncomment the following:
    /*
    final MobileScannerController controller = MobileScannerController();
    
    try {
      final result = await Navigator.push<String?>(
        context,
        MaterialPageRoute(
          builder: (context) => BarcodeScannerPage(controller: controller),
        ),
      );
      
      return result;
    } finally {
      controller.dispose();
    }
    */
    
    return null;
  }
}

// Web implementation using manual input dialog
class WebBarcodeScannerService implements BarcodeScannerService {
  @override
  bool get isSupported => kIsWeb;
  
  @override
  Future<String?> scanBarcode() async {
    // For web, return null to indicate manual input is needed
    // The calling code should handle this by showing a dialog
    // This avoids throwing errors and allows graceful fallback
    return null;
  }
}

class BarcodeScannerServiceFactory {
  static BarcodeScannerService create() {
    if (kIsWeb) {
      return WebBarcodeScannerService();
    }
    return BarcodeScannerServiceImpl();
  }
}