import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";
import "package:intl/intl.dart";

void main() {
  group("twoDecimalsDouble", () {
    test("rounds to two decimal places", () {
      expect(1.005.twoDecimalsDouble, double.parse((1.005).toStringAsFixed(2)));
    });

    test("integers are unaffected", () {
      expect(5.twoDecimalsDouble, 5.0);
    });

    test("already-2-decimal values are unaffected", () {
      expect(19.99.twoDecimalsDouble, 19.99);
    });
  });

  group("toCurrencyString()", () {
    test("uses the default symbol and 2 decimal digits", () {
      final expected = NumberFormat.currency(
        locale: "es_MX",
        symbol: r"$ ",
        decimalDigits: 2,
      ).format(1000).replaceAll(RegExp(r"\$"), r"$ ");

      expect(1000.toCurrencyString(), expected);
    });

    test("honors a custom symbol", () {
      final result = 1000.toCurrencyString(symbol: "USD ");

      expect(result, contains("USD"));
    });

    test("honors custom decimalDigits", () {
      final expected = NumberFormat.currency(
        locale: "es_MX",
        symbol: r"$ ",
        decimalDigits: 0,
      ).format(1000).replaceAll(RegExp(r"\$"), r"$ ");

      expect(1000.toCurrencyString(decimalDigits: 0), expected);
    });
  });

  group("isBetween()", () {
    test("value inside the range", () {
      expect(5.isBetween(1, 10), isTrue);
    });

    test("value exactly on the min boundary is inclusive", () {
      expect(1.isBetween(1, 10), isTrue);
    });

    test("value exactly on the max boundary is inclusive", () {
      expect(10.isBetween(1, 10), isTrue);
    });

    test("value below the range", () {
      expect(0.isBetween(1, 10), isFalse);
    });

    test("value above the range", () {
      expect(11.isBetween(1, 10), isFalse);
    });
  });
}
