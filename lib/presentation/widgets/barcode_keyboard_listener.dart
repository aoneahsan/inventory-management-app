import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeKeyboardListener extends StatefulWidget {
  final Widget child;
  final Function(String) onBarcodeScanned;
  final Duration scanTimeout;

  const BarcodeKeyboardListener({
    super.key,
    required this.child,
    required this.onBarcodeScanned,
    this.scanTimeout = const Duration(milliseconds: 100),
  });

  @override
  State<BarcodeKeyboardListener> createState() => _BarcodeKeyboardListenerState();
}

class _BarcodeKeyboardListenerState extends State<BarcodeKeyboardListener> {
  final StringBuffer _barcodeBuffer = StringBuffer();
  DateTime? _lastKeyTime;

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final now = DateTime.now();
    
    // Reset buffer if too much time has passed since last key
    if (_lastKeyTime != null && 
        now.difference(_lastKeyTime!) > widget.scanTimeout) {
      _barcodeBuffer.clear();
    }
    
    _lastKeyTime = now;

    // Handle Enter key (barcode scanners usually send Enter after scanning)
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (_barcodeBuffer.isNotEmpty) {
        final barcode = _barcodeBuffer.toString();
        _barcodeBuffer.clear();
        widget.onBarcodeScanned(barcode);
      }
      return;
    }

    // Handle character input
    final character = event.character;
    if (character != null && character.isNotEmpty) {
      // Only accept alphanumeric characters and common barcode characters
      if (RegExp(r'^[a-zA-Z0-9\-_]+$').hasMatch(character)) {
        _barcodeBuffer.write(character);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        _handleKeyEvent(event);
        return KeyEventResult.ignored;
      },
      child: widget.child,
    );
  }
}