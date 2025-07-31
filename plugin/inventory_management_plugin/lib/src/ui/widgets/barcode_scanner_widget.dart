import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/barcode/barcode_service.dart';

/// Reusable barcode scanner widget
class BarcodeScannerWidget extends StatefulWidget {
  final Function(BarcodeParseResult) onScanned;
  final bool continuous;
  final bool showOverlay;
  final String? overlayText;
  final BarcodeService barcodeService;

  const BarcodeScannerWidget({
    Key? key,
    required this.onScanned,
    required this.barcodeService,
    this.continuous = false,
    this.showOverlay = true,
    this.overlayText,
  }) : super(key: key);

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  MobileScannerController cameraController = MobileScannerController();
  bool hasScanned = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: cameraController,
          onDetect: (capture) async {
            if (!widget.continuous && hasScanned) return;

            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (barcode.rawValue != null) {
                hasScanned = true;
                
                // Parse barcode
                final result = await widget.barcodeService.parseBarcode(
                  barcode.rawValue!,
                );

                if (result != null) {
                  widget.onScanned(result);
                  
                  if (!widget.continuous) {
                    // Stop scanning after first successful scan
                    cameraController.stop();
                  }
                }
              }
            }
          },
        ),
        if (widget.showOverlay) _buildOverlay(context),
        Positioned(
          top: 40,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state) {
                        case TorchState.off:
                          return const Icon(
                            Icons.flash_off,
                            color: Colors.white,
                          );
                        case TorchState.on:
                          return const Icon(
                            Icons.flash_on,
                            color: Colors.yellow,
                          );
                      }
                    },
                  ),
                  onPressed: () => cameraController.toggleTorch(),
                ),
                const SizedBox(width: 32),
                IconButton(
                  icon: const Icon(
                    Icons.flip_camera_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => cameraController.switchCamera(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
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
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Text(
              widget.overlayText ?? 'Scan barcode',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Barcode scanner button that launches the scanner
class BarcodeScannerButton extends StatelessWidget {
  final Function(BarcodeParseResult) onScanned;
  final BarcodeService barcodeService;
  final Widget? child;
  final bool continuous;
  final String? overlayText;

  const BarcodeScannerButton({
    Key? key,
    required this.onScanned,
    required this.barcodeService,
    this.child,
    this.continuous = false,
    this.overlayText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child != null
        ? InkWell(
            onTap: () => _openScanner(context),
            child: child,
          )
        : IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => _openScanner(context),
          );
  }

  void _openScanner(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          body: BarcodeScannerWidget(
            onScanned: (result) {
              Navigator.of(context).pop();
              onScanned(result);
            },
            barcodeService: barcodeService,
            continuous: continuous,
            overlayText: overlayText,
          ),
        ),
      ),
    );
  }
}