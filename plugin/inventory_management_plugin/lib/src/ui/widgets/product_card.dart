import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

/// Reusable product card widget
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget? trailing;
  final bool showStock;
  final double? stockLevel;
  final bool showPrice;
  final bool showActions;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.trailing,
    this.showStock = true,
    this.stockLevel,
    this.showPrice = true,
    this.showActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image or placeholder
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: product.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  _buildImagePlaceholder(theme),
                            ),
                          )
                        : _buildImagePlaceholder(theme),
                  ),
                  const SizedBox(width: 12),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        if (product.sku != null)
                          Text(
                            'SKU: ${product.sku}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        if (product.barcode != null)
                          Text(
                            'Barcode: ${product.barcode}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                  if (showActions) _buildActions(context),
                ],
              ),
              const SizedBox(height: 12),
              // Bottom row with price and stock
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showPrice) _buildPriceSection(theme),
                  if (showStock) _buildStockIndicator(theme),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(ThemeData theme) {
    return Icon(
      Icons.inventory_2_outlined,
      size: 32,
      color: theme.colorScheme.onSurfaceVariant,
    );
  }

  Widget _buildActions(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
        }
      },
      itemBuilder: (context) => [
        if (onEdit != null)
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 20),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
          ),
        if (onDelete != null)
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 20),
                SizedBox(width: 8),
                Text('Delete'),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPriceSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.sellingPrice != null)
          Text(
            '\$${product.sellingPrice!.toStringAsFixed(2)}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (product.costPrice != null && product.sellingPrice != null)
          Text(
            'Cost: \$${product.costPrice!.toStringAsFixed(2)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }

  Widget _buildStockIndicator(ThemeData theme) {
    if (!product.trackInventory) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Not Tracked',
          style: theme.textTheme.bodySmall,
        ),
      );
    }

    final stock = stockLevel ?? 0;
    final stockStatus = _getStockStatus(stock, product.reorderLevel ?? 0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: stockStatus.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: stockStatus.color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            stockStatus.icon,
            size: 16,
            color: stockStatus.color,
          ),
          const SizedBox(width: 4),
          Text(
            '${stock.toStringAsFixed(0)} ${product.unit}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: stockStatus.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  StockStatus _getStockStatus(double stock, double reorderLevel) {
    if (stock == 0) {
      return StockStatus(
        color: Colors.red,
        icon: Icons.error_outline,
        label: 'Out of Stock',
      );
    } else if (stock <= reorderLevel) {
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