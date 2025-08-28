import "package:intl/intl.dart";

/// Extension for common operations on num
extension NumExtension on num {
  /// Returns a double with two decimal places.
  double get twoDecimalsDouble => double.parse(toStringAsFixed(2));

  /// Converts a number to a currency string
  /// Example: 1000.0.toCurrencyString() -> $ 1,000.00
  String toCurrencyString({String symbol = r"$ ", int decimalDigits = 2}) {
    final formatter = NumberFormat.currency(
      locale: "es_MX",
      symbol: symbol,
      decimalDigits: decimalDigits,
    );

    final String textFormated = formatter.format(this);

    return textFormated.replaceAll(RegExp(r"\$"), r"$ ");
  }

  /// True if the number is between [min] and [max]
  bool isBetween(num min, num max) => this >= min && this <= max;
}
