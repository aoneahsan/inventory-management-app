import 'package:flutter/material.dart';

class StockLevelBadge extends StatelessWidget {
  final double currentStock;
  final double? reorderLevel;
  final String? unit;
  final bool showQuantity;

  const StockLevelBadge({
    Key? key,
    required this.currentStock,
    this.reorderLevel,
    this.unit,
    this.showQuantity = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = _getStockStatus();
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: status.color.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status.icon,
            size: 14,
            color: status.color,
          ),
          if (showQuantity) ...[
            const SizedBox(width: 4),
            Text(
              '${currentStock.toStringAsFixed(currentStock.truncateToDouble() == currentStock ? 0 : 1)}${unit != null ? ' $unit' : ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: status.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  _StockStatus _getStockStatus() {
    if (currentStock <= 0) {
      return _StockStatus(
        icon: Icons.error_outline,
        color: Colors.red,
        label: 'Out of Stock',
      );
    } else if (reorderLevel != null && currentStock <= reorderLevel!) {
      return _StockStatus(
        icon: Icons.warning_amber,
        color: Colors.orange,
        label: 'Low Stock',
      );
    } else {
      return _StockStatus(
        icon: Icons.check_circle_outline,
        color: Colors.green,
        label: 'In Stock',
      );
    }
  }
}

class _StockStatus {
  final IconData icon;
  final Color color;
  final String label;

  const _StockStatus({
    required this.icon,
    required this.color,
    required this.label,
  });
}