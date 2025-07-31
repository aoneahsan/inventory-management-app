import 'package:flutter/material.dart';

/// Widget to display stock level with visual indicators
class StockLevelIndicator extends StatelessWidget {
  final double currentStock;
  final double? reorderLevel;
  final double? maxStock;
  final String unit;
  final bool showNumbers;
  final bool showBar;
  final double? width;
  final double? height;

  const StockLevelIndicator({
    Key? key,
    required this.currentStock,
    this.reorderLevel,
    this.maxStock,
    this.unit = 'units',
    this.showNumbers = true,
    this.showBar = true,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stockStatus = _getStockStatus();

    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: stockStatus.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: stockStatus.color.withOpacity(0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                stockStatus.icon,
                color: stockStatus.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                stockStatus.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: stockStatus.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (showNumbers) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current:',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  '${currentStock.toStringAsFixed(0)} $unit',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (reorderLevel != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reorder at:',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    '${reorderLevel!.toStringAsFixed(0)} $unit',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ],
          if (showBar && maxStock != null && maxStock! > 0) ...[
            const SizedBox(height: 12),
            _buildStockBar(theme, stockStatus),
          ],
        ],
      ),
    );
  }

  Widget _buildStockBar(ThemeData theme, StockStatus status) {
    final percentage = (currentStock / maxStock!).clamp(0.0, 1.0);
    final reorderPercentage = reorderLevel != null
        ? (reorderLevel! / maxStock!).clamp(0.0, 1.0)
        : 0.0;

    return SizedBox(
      height: height ?? 8,
      child: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // Reorder level indicator
          if (reorderLevel != null)
            FractionallySizedBox(
              widthFactor: reorderPercentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          // Current stock level
          FractionallySizedBox(
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: status.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StockStatus _getStockStatus() {
    if (currentStock == 0) {
      return StockStatus(
        color: Colors.red,
        icon: Icons.error_outline,
        label: 'Out of Stock',
      );
    } else if (reorderLevel != null && currentStock <= reorderLevel!) {
      return StockStatus(
        color: Colors.orange,
        icon: Icons.warning_amber_outlined,
        label: 'Low Stock',
      );
    } else {
      return StockStatus(
        color: Colors.green,
        icon: Icons.check_circle_outline,
        label: 'In Stock',
      );
    }
  }
}

/// Compact stock level badge
class StockLevelBadge extends StatelessWidget {
  final double currentStock;
  final double? reorderLevel;
  final String unit;
  final bool showIcon;

  const StockLevelBadge({
    Key? key,
    required this.currentStock,
    this.reorderLevel,
    this.unit = '',
    this.showIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = _getStockStatus();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: status.color.withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              status.icon,
              size: 14,
              color: status.color,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            '${currentStock.toStringAsFixed(0)}${unit.isNotEmpty ? ' $unit' : ''}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: status.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  StockStatus _getStockStatus() {
    if (currentStock == 0) {
      return StockStatus(
        color: Colors.red,
        icon: Icons.error_outline,
        label: 'Out of Stock',
      );
    } else if (reorderLevel != null && currentStock <= reorderLevel!) {
      return StockStatus(
        color: Colors.orange,
        icon: Icons.warning_amber_outlined,
        label: 'Low Stock',
      );
    } else {
      return StockStatus(
        color: Colors.green,
        icon: Icons.check_circle_outline,
        label: 'In Stock',
      );
    }
  }
}

class StockStatus {
  final Color color;
  final IconData icon;
  final String label;

  StockStatus({
    required this.color,
    required this.icon,
    required this.label,
  });
}