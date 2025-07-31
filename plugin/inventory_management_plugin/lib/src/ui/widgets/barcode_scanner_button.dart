import 'package:flutter/material.dart';
import '../../services/barcode/barcode_service.dart';
import 'barcode_scanner_widget.dart';

class BarcodeScannerButton extends StatelessWidget {
  final BarcodeService barcodeService;
  final void Function(BarcodeParseResult) onScanned;
  final IconData icon;
  final String? tooltip;

  const BarcodeScannerButton({
    Key? key,
    required this.barcodeService,
    required this.onScanned,
    this.icon = Icons.qr_code_scanner,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip ?? 'Scan barcode',
      onPressed: () => _showScanner(context),
    );
  }

  void _showScanner(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Scan Barcode',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Scanner
            Expanded(
              child: BarcodeScannerWidget(
                onScan: (barcode) async {
                  final result = await barcodeService.parseBarcode(barcode);
                  if (result != null) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      onScanned(result);
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid barcode format'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                continuousMode: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}