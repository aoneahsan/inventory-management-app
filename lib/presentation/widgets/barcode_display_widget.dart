import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BarcodeDisplayWidget extends StatelessWidget {
  final String barcode;
  final double size;
  final bool showLabel;

  const BarcodeDisplayWidget({
    super.key,
    required this.barcode,
    this.size = 200,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: QrImageView(
            data: barcode,
            version: QrVersions.auto,
            size: size,
            backgroundColor: Colors.white,
            errorCorrectionLevel: QrErrorCorrectLevel.M,
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 8),
          Text(
            barcode,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

// Dialog to show barcode in larger size
Future<void> showBarcodeDialog(BuildContext context, String barcode, String productName) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(productName),
      content: BarcodeDisplayWidget(
        barcode: barcode,
        size: 250,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}