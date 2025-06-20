// lib/core/enums/currency_enum.dart

enum CurrencyType { usd, eur, idr, jpy, sgd }

extension CurrencyTypeExtension on CurrencyType {
  String get label {
    switch (this) {
      case CurrencyType.usd:
        return 'USD';
      case CurrencyType.eur:
        return 'EUR';
      case CurrencyType.idr:
        return 'IDR';
      case CurrencyType.jpy:
        return 'JPY';
      case CurrencyType.sgd:
        return 'SGD';
    }
  }
}
