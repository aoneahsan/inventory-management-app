import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/currency.dart';
import '../../core/errors/exceptions.dart';

class CurrencyService {
  final FirebaseFirestore _firestore;
  final Dio _dio;
  static const String _apiKey = 'YOUR_EXCHANGE_RATE_API_KEY'; // Replace with actual API key
  static const String _apiUrl = 'https://api.exchangerate-api.com/v4/latest/USD';

  CurrencyService({
    FirebaseFirestore? firestore,
    Dio? dio,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _dio = dio ?? Dio();

  // Get all available currencies
  Future<List<Currency>> getAvailableCurrencies() async {
    try {
      // First try to get from Firestore cache
      final snapshot = await _firestore
          .collection('currencies')
          .orderBy('code')
          .get();

      if (snapshot.docs.isNotEmpty) {
        final currencies = snapshot.docs.map((doc) {
          final data = doc.data();
          data['code'] = doc.id;
          return Currency.fromJson(data);
        }).toList();

        // Check if rates are older than 24 hours
        final oldestUpdate = currencies
            .map((c) => c.lastUpdated)
            .reduce((a, b) => a.isBefore(b) ? a : b);

        if (DateTime.now().difference(oldestUpdate).inHours < 24) {
          return currencies;
        }
      }

      // If no cache or outdated, return default currencies
      return Currency.defaultCurrencies;
    } catch (e) {
      throw BusinessException(message: 'Failed to load currencies: $e');
    }
  }

  // Update exchange rates from API
  Future<void> updateExchangeRates() async {
    try {
      // Fetch latest rates from API
      final response = await _dio.get(_apiUrl);
      final rates = response.data['rates'] as Map<String, dynamic>;
      final timestamp = DateTime.parse(response.data['date'] as String);

      // Update each currency in Firestore
      final batch = _firestore.batch();

      for (final currency in Currency.defaultCurrencies) {
        final rate = rates[currency.code]?.toDouble() ?? currency.exchangeRate;
        
        batch.set(
          _firestore.collection('currencies').doc(currency.code),
          currency.copyWith(
            exchangeRate: rate,
            lastUpdated: timestamp,
          ).toJson(),
        );
      }

      await batch.commit();
    } catch (e) {
      print('Error updating exchange rates: $e');
      // Don't throw error, just use cached rates
    }
  }

  // Get organization's default currency
  Future<Currency> getOrganizationCurrency(String organizationId) async {
    try {
      final doc = await _firestore
          .collection('organizations')
          .doc(organizationId)
          .get();

      if (doc.exists) {
        final currencyCode = doc.data()?['currency_code'] as String?;
        if (currencyCode != null) {
          final currencies = await getAvailableCurrencies();
          return currencies.firstWhere(
            (c) => c.code == currencyCode,
            orElse: () => Currency.usd(),
          );
        }
      }

      return Currency.usd();
    } catch (e) {
      return Currency.usd();
    }
  }

  // Set organization's default currency
  Future<void> setOrganizationCurrency(
    String organizationId,
    String currencyCode,
  ) async {
    try {
      await _firestore.collection('organizations').doc(organizationId).update({
        'currency_code': currencyCode,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw BusinessException(message: 'Failed to update currency: $e');
    }
  }

  // Convert price between currencies
  double convertPrice({
    required double amount,
    required Currency from,
    required Currency to,
  }) {
    if (from.code == to.code) return amount;
    return from.convert(amount, to);
  }

  // Format price with currency
  String formatPrice({
    required double amount,
    required Currency currency,
    bool includeCode = false,
  }) {
    final formatted = currency.format(amount);
    return includeCode ? '$formatted ${currency.code}' : formatted;
  }

  // Get currency by code
  Future<Currency?> getCurrencyByCode(String code) async {
    try {
      final currencies = await getAvailableCurrencies();
      return currencies.firstWhere(
        (c) => c.code == code,
        orElse: () => Currency.usd(),
      );
    } catch (e) {
      return null;
    }
  }

  // Batch convert prices
  Map<String, double> batchConvertPrices({
    required Map<String, double> prices,
    required Currency from,
    required Currency to,
  }) {
    if (from.code == to.code) return prices;

    return prices.map((key, value) => MapEntry(
      key,
      convertPrice(amount: value, from: from, to: to),
    ));
  }

  // Get exchange rate between two currencies
  double getExchangeRate({
    required Currency from,
    required Currency to,
  }) {
    if (from.code == to.code) return 1.0;
    
    // Convert through USD as base
    final fromUsdRate = from.isBaseCurrency ? 1.0 : from.exchangeRate;
    final toUsdRate = to.isBaseCurrency ? 1.0 : to.exchangeRate;
    
    return toUsdRate / fromUsdRate;
  }
}