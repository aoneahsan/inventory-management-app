import 'package:flutter/material.dart';
// Uncomment when mobile_scanner is enabled
// import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  // Uncomment when mobile_scanner is enabled
  // late MobileScannerController controller;
  // Field removed as it's not used with mobile_scanner commented out

  @override
  void initState() {
    super.initState();
    // Uncomment when mobile_scanner is enabled
    // controller = MobileScannerController(
    //   facing: CameraFacing.back,
    //   detectionSpeed: DetectionSpeed.normal,
    // );
  }

  @override
  void dispose() {
    // Uncomment when mobile_scanner is enabled
    // controller.dispose();
    super.dispose();
  }

  // Uncomment when mobile_scanner is enabled
  // void _onDetect(String barcode) {
  //   if (!_hasScanned) {
  //     _hasScanned = true;
  //     Navigator.of(context).pop(barcode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () {
              // Uncomment when mobile_scanner is enabled
              // controller.toggleTorch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () {
              // Uncomment when mobile_scanner is enabled
              // controller.switchCamera();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Placeholder for when mobile_scanner is disabled
          Container(
            color: Colors.black,
            child: const Center(
              child: Text(
                'Camera preview not available.\nMobile scanner is disabled for web compatibility.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          
          // Uncomment when mobile_scanner is enabled
          /*
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                _onDetect(barcodes.first.rawValue!);
              }
            },
          ),
          */
          
          // Overlay with scanning frame
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Place barcode inside the frame',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}