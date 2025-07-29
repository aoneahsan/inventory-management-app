import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeInputDialog extends StatefulWidget {
  const BarcodeInputDialog({super.key});

  @override
  State<BarcodeInputDialog> createState() => _BarcodeInputDialogState();
}

class _BarcodeInputDialogState extends State<BarcodeInputDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    // Auto-focus on the text field for quick entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.qr_code_scanner),
          SizedBox(width: 8),
          Text('Scan Barcode'),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter barcode manually or use a barcode scanner:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Barcode',
                hintText: 'Enter or scan barcode',
                prefixIcon: Icon(Icons.qr_code),
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                // Allow alphanumeric and common barcode characters
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-_]')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a barcode';
                }
                if (value.length < 3) {
                  return 'Barcode must be at least 3 characters';
                }
                return null;
              },
              onFieldSubmitted: (_) => _submitBarcode(),
            ),
            const SizedBox(height: 16),
            if (_isScanning)
              const Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Scanning...'),
                ],
              ),
            const SizedBox(height: 8),
            const Text(
              'Tip: Connect a USB barcode scanner for automatic input',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitBarcode,
          child: const Text('OK'),
        ),
      ],
    );
  }

  void _submitBarcode() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }
}

// Helper function to show the barcode input dialog
Future<String?> showBarcodeInputDialog(BuildContext context) {
  return showDialog<String?>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const BarcodeInputDialog(),
  );
}