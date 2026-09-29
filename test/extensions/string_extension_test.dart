import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("toCapitalized()", () {
    test("empty string stays empty", () {
      expect("".toCapitalized(), "");
    });

    test("capitalizes the first letter only", () {
      expect("hello".toCapitalized(), "Hello");
    });

    test("single character string", () {
      expect("h".toCapitalized(), "H");
    });

    test("already-capitalized string is unchanged", () {
      expect("Hello".toCapitalized(), "Hello");
    });
  });

  group("toTitleCase()", () {
    test("capitalizes words longer than 2 chars, skips small connector words", () {
      expect("la casa de juan".toTitleCase(), "la Casa de Juan");
    });

    test("words of length <= 2 are left untouched even if not in the exclusion list", () {
      expect("un dia".toTitleCase(), "un Dia");
    });

    test("single word input", () {
      expect("hello".toTitleCase(), "Hello");
    });

    test("empty string", () {
      expect("".toTitleCase(), "");
    });
  });

  group("toDate()", () {
    test("parses a valid date with the default format", () {
      final date = "2024-01-05 10:30:00".toDate();

      expect(date, DateTime(2024, 1, 5, 10, 30));
    });

    test("parses a valid date with a custom format", () {
      final date = "05/01/2024".toDate(format: "dd/MM/yyyy");

      expect(date, DateTime(2024, 1, 5));
    });

    test("returns null for an unparsable string", () {
      expect("not a date".toDate(), isNull);
    });
  });

  group("toCurrencyFormat()", () {
    test("formats a parseable numeric string as currency", () {
      final formatted = "1000".toCurrencyFormat();

      expect(formatted, (1000.0).toCurrencyString());
    });

    test("returns the original string when it is not parseable as a double", () {
      expect("not a number".toCurrencyFormat(), "not a number");
    });
  });

  group("toCreditCardFormat()", () {
    test("groups digits in blocks of 4 separated by the source's double space", () {
      expect(
        "1234567890123456".toCreditCardFormat(),
        "1234  5678  9012  3456",
      );
    });

    test("handles a length that is not a multiple of 4", () {
      expect("12345".toCreditCardFormat(), "1234  5");
    });
  });

  group("formattedCard()", () {
    test("length not divisible by 4 returns the fully masked placeholder", () {
      expect("12345".formattedCard(), "**** **** **** ****");
    });

    test("length divisible by 4 groups digits with single spaces, trimmed", () {
      expect("1234567890123456".formattedCard(), "1234 5678 9012 3456");
    });
  });
}
