import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/currency.dart';
import '../../../services/currency/currency_service.dart';
import '../../providers/organization_provider.dart';

final currencyServiceProvider = Provider<CurrencyService>((ref) {
  return CurrencyService();
});

final availableCurrenciesProvider = FutureProvider<List<Currency>>((ref) async {
  final service = ref.watch(currencyServiceProvider);
  return service.getAvailableCurrencies();
});

final organizationCurrencyProvider = FutureProvider<Currency>((ref) async {
  final organization = ref.watch(currentOrganizationProvider);
  if (organization == null) return Currency.usd();
  
  final service = ref.watch(currencyServiceProvider);
  return service.getOrganizationCurrency(organization.id);
});

class CurrencySettingsPage extends ConsumerStatefulWidget {
  const CurrencySettingsPage({super.key});

  @override
  ConsumerState<CurrencySettingsPage> createState() => _CurrencySettingsPageState();
}

class _CurrencySettingsPageState extends ConsumerState<CurrencySettingsPage> {
  Currency? _selectedCurrency;
  bool _isUpdating = false;
  final _testAmountController = TextEditingController(text: '100');

  @override
  void dispose() {
    _testAmountController.dispose();
    super.dispose();
  }

  Future<void> _updateCurrency(Currency currency) async {
    final organization = ref.read(currentOrganizationProvider);
    if (organization == null) return;

    setState(() => _isUpdating = true);

    try {
      final service = ref.read(currencyServiceProvider);
      await service.setOrganizationCurrency(organization.id, currency.code);
      
      // Refresh the provider
      ref.invalidate(organizationCurrencyProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Currency updated to ${currency.name}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating currency: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  Future<void> _refreshExchangeRates() async {
    setState(() => _isUpdating = true);

    try {
      final service = ref.read(currencyServiceProvider);
      await service.updateExchangeRates();
      
      // Refresh the providers
      ref.invalidate(availableCurrenciesProvider);
      ref.invalidate(organizationCurrencyProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Exchange rates updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating exchange rates: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currenciesAsync = ref.watch(availableCurrenciesProvider);
    final currentCurrencyAsync = ref.watch(organizationCurrencyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isUpdating ? null : _refreshExchangeRates,
            tooltip: 'Update exchange rates',
          ),
        ],
      ),
      body: currenciesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (currencies) => currentCurrencyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (currentCurrency) {
            _selectedCurrency ??= currentCurrency;
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              const Text(
                                'Currency Configuration',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Select your organization\'s default currency. All prices will be displayed in this currency.',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Current Currency: ',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${currentCurrency.name} (${currentCurrency.symbol})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Available Currencies',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...currencies.map((currency) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: RadioListTile<Currency>(
                      value: currency,
                      groupValue: _selectedCurrency,
                      onChanged: _isUpdating ? null : (value) {
                        setState(() {
                          _selectedCurrency = value;
                        });
                      },
                      title: Text(currency.name),
                      subtitle: Text('${currency.code} - Exchange rate: ${currency.exchangeRate}'),
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currency.symbol,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                  const SizedBox(height: 24),
                  
                  // Currency Converter
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Currency Converter',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _testAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Amount in ${currentCurrency.name}',
                              prefix: Text('${currentCurrency.symbol} '),
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 16),
                          if (_testAmountController.text.isNotEmpty) ...[
                            const Text(
                              'Converted Values:',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            ...currencies.where((c) => c.code != currentCurrency.code).map((currency) {
                              final amount = double.tryParse(_testAmountController.text) ?? 0;
                              final converted = ref.read(currencyServiceProvider).convertPrice(
                                amount: amount,
                                from: currentCurrency,
                                to: currency,
                              );
                              
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(currency.name),
                                    Text(
                                      currency.format(converted),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isUpdating || _selectedCurrency == currentCurrency
                          ? null
                          : () => _updateCurrency(_selectedCurrency!),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                      child: _isUpdating
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Update Currency'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.amber.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.warning_amber, color: Colors.amber[700]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Important Note',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Changing the currency will affect how all prices are displayed in your organization. '
                                  'The actual values stored in the database will not change.',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}