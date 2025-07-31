import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/pos_settings.dart';
import '../../../domain/entities/register.dart';
import '../../../services/pos/register_service.dart';
import '../../../services/database/database.dart';
import '../../../services/sync/sync_service.dart';
import '../../providers/auth_provider.dart';
import 'pos_main_page.dart';

final registerServiceProvider = Provider<RegisterService>((ref) {
  return RegisterService(
    database: AppDatabase.instance,
    syncService: ref.watch(syncServiceProvider),
  );
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(database: AppDatabase.instance);
});

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  String _selectedPaymentMethod = PaymentMethod.cash;
  final Map<String, double> _splitPayments = {};
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final posService = ref.watch(posServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/pos'),
        ),
      ),
      body: Row(
        children: [
          // Payment Options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  // Payment method selection
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildPaymentOption(
                        PaymentMethod.cash,
                        Icons.payments,
                        'Cash',
                      ),
                      _buildPaymentOption(
                        PaymentMethod.card,
                        Icons.credit_card,
                        'Card',
                      ),
                      _buildPaymentOption(
                        PaymentMethod.upi,
                        Icons.phone_android,
                        'UPI',
                      ),
                      _buildPaymentOption(
                        PaymentMethod.wallet,
                        Icons.account_balance_wallet,
                        'Wallet',
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Cash payment details
                  if (_selectedPaymentMethod == PaymentMethod.cash) ...[
                    Text(
                      'Cash Payment',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Amount Received',
                              prefixText: '\$',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // Calculate change
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Change'),
                                Text(
                                  '\$0.00',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // Order Summary
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(-2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Summary Header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                
                // Items
                Expanded(
                  child: ListView.builder(
                    itemCount: posService.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = posService.cartItems[index];
                      return ListTile(
                        title: Text(item.productName),
                        subtitle: Text('${item.quantity} x \$${item.unitPrice.toStringAsFixed(2)}'),
                        trailing: Text(
                          '\$${item.totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    },
                  ),
                ),
                
                // Totals
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow('Subtotal', posService.subtotal),
                      if (posService.discountTotal > 0)
                        _buildSummaryRow('Discount', -posService.discountTotal),
                      if (posService.taxTotal > 0)
                        _buildSummaryRow('Tax', posService.taxTotal),
                      const Divider(),
                      _buildSummaryRow(
                        'Total',
                        posService.total,
                        isTotal: true,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isProcessing
                              ? null
                              : () async {
                                  await _processSale();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: _isProcessing
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Complete Sale',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, IconData icon, String label) {
    final isSelected = _selectedPaymentMethod == method;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
              : Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: isTotal
                ? Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    )
                : Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Future<void> _processSale() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final posService = ref.read(posServiceProvider);
      final currentUser = ref.read(currentUserProvider);
      final currentOrg = ref.read(currentOrganizationProvider);
      final registerService = ref.read(registerServiceProvider);
      
      if (currentOrg == null || currentUser == null) {
        throw Exception('Organization or user not found');
      }
      
      // Get open register
      final registers = await registerService.getOpenRegisters(
        currentOrg.id,
      );
      
      if (registers.isEmpty) {
        throw Exception('No open register found. Please open a register first.');
      }

      // Process the sale
      final sale = await posService.processSale(
        organizationId: currentOrg.id,
        registerId: registers.first.id,
        userId: currentUser.id,
        paymentMethod: _selectedPaymentMethod,
        splitPayments: _splitPayments.isNotEmpty ? _splitPayments : null,
      );

      // Add transaction to register
      await registerService.addTransaction(
        registerId: registers.first.id,
        type: RegisterTransactionType.sale,
        amount: sale.totalAmount,
        performedBy: currentUser.id,
      );

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sale completed! Receipt #${sale.receiptNumber}'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate back to POS
        context.go('/pos');
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}