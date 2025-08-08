import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String code;
  final String name;
  final String symbol;
  final int decimalDigits;
  final double exchangeRate; // Rate to base currency (USD)
  final bool isBaseCurrency;
  final DateTime lastUpdated;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.decimalDigits,
    required this.exchangeRate,
    this.isBaseCurrency = false,
    required this.lastUpdated,
  });

  factory Currency.usd() => Currency(
    code: 'USD',
    name: 'US Dollar',
    symbol: '\$',
    decimalDigits: 2,
    exchangeRate: 1.0,
    isBaseCurrency: true,
    lastUpdated: DateTime.now(),
  );

  factory Currency.eur() => Currency(
    code: 'EUR',
    name: 'Euro',
    symbol: '€',
    decimalDigits: 2,
    exchangeRate: 0.85,
    lastUpdated: DateTime.now(),
  );

  factory Currency.gbp() => Currency(
    code: 'GBP',
    name: 'British Pound',
    symbol: '£',
    decimalDigits: 2,
    exchangeRate: 0.73,
    lastUpdated: DateTime.now(),
  );

  factory Currency.jpy() => Currency(
    code: 'JPY',
    name: 'Japanese Yen',
    symbol: '¥',
    decimalDigits: 0,
    exchangeRate: 110.0,
    lastUpdated: DateTime.now(),
  );

  factory Currency.cad() => Currency(
    code: 'CAD',
    name: 'Canadian Dollar',
    symbol: 'C\$',
    decimalDigits: 2,
    exchangeRate: 1.25,
    lastUpdated: DateTime.now(),
  );

  factory Currency.aud() => Currency(
    code: 'AUD',
    name: 'Australian Dollar',
    symbol: 'A\$',
    decimalDigits: 2,
    exchangeRate: 1.35,
    lastUpdated: DateTime.now(),
  );

  factory Currency.inr() => Currency(
    code: 'INR',
    name: 'Indian Rupee',
    symbol: '₹',
    decimalDigits: 2,
    exchangeRate: 74.5,
    lastUpdated: DateTime.now(),
  );

  factory Currency.cny() => Currency(
    code: 'CNY',
    name: 'Chinese Yuan',
    symbol: '¥',
    decimalDigits: 2,
    exchangeRate: 6.45,
    lastUpdated: DateTime.now(),
  );

  // Convert amount from this currency to base currency (USD)
  double toBase(double amount) {
    if (isBaseCurrency) return amount;
    return amount / exchangeRate;
  }

  // Convert amount from base currency (USD) to this currency
  double fromBase(double amount) {
    if (isBaseCurrency) return amount;
    return amount * exchangeRate;
  }

  // Convert between two currencies
  double convert(double amount, Currency to) {
    final baseAmount = toBase(amount);
    return to.fromBase(baseAmount);
  }

  // Format amount with currency symbol
  String format(double amount) {
    final formatted = amount.toStringAsFixed(decimalDigits);
    return '$symbol$formatted';
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'symbol': symbol,
      'decimal_digits': decimalDigits,
      'exchange_rate': exchangeRate,
      'is_base_currency': isBaseCurrency,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalDigits: json['decimal_digits'] as int,
      exchangeRate: (json['exchange_rate'] as num).toDouble(),
      isBaseCurrency: json['is_base_currency'] as bool? ?? false,
      lastUpdated: DateTime.parse(json['last_updated'] as String),
    );
  }

  Currency copyWith({
    String? code,
    String? name,
    String? symbol,
    int? decimalDigits,
    double? exchangeRate,
    bool? isBaseCurrency,
    DateTime? lastUpdated,
  }) {
    return Currency(
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimalDigits: decimalDigits ?? this.decimalDigits,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      isBaseCurrency: isBaseCurrency ?? this.isBaseCurrency,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
    code,
    name,
    symbol,
    decimalDigits,
    exchangeRate,
    isBaseCurrency,
    lastUpdated,
  ];

  static final List<Currency> defaultCurrencies = [
    Currency.usd(),
    Currency.eur(),
    Currency.gbp(),
    Currency.jpy(),
    Currency.cad(),
    Currency.aud(),
    Currency.inr(),
    Currency.cny(),
  ];
}