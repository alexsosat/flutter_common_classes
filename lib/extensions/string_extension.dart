import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "num_extension.dart";

/// A set of useful extensions for the [String] class.
extension StringExtension on String {
  /// Capitalizes the first letter of the string
  String toCapitalized() =>
      length > 0 ? "${this[0].toUpperCase()}${characters.getRange(1)}" : "";

  /// Capitalizes the first letter of each word in the string
  ///
  /// Example: "hello world" -> "Hello World"
  ///
  /// Excludes the words:
  ///  "de", "del", "la", "las", "los", "y", "e", "o", "u", "a"
  String toTitleCase() {
    final List<String> words = split(" ");
    final List<String> capitalizedWords = <String>[];

    for (String word in words) {
      if (word.length > 2 &&
          !["de", "del", "la", "las", "los", "y", "e", "o", "u", "a"]
              .contains(word.toLowerCase())) {
        capitalizedWords.add(word.toCapitalized());
      } else {
        capitalizedWords.add(word);
      }
    }

    return capitalizedWords.join(" ");
  }

  /// Converts the string to a date object using the [format] specified
  DateTime? toDate({String format = "yyyy-MM-dd HH:mm:ss"}) {
    final DateFormat dateFormat = DateFormat(format);

    try {
      return dateFormat.parse(this);
    } catch (e) {
      return null;
    }
  }

  /// Converts the string to a currency format string
  String toCurrencyFormat() {
    try {
      final double value = double.parse(this);

      return value.toCurrencyString();
    } catch (e) {
      return this;
    }
  }

  /// Converts the string to a credit card format string
  ///
  /// Example: "1234567890123456" -> "1234 5678 9012 3456"
  String toCreditCardFormat() {
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      if (i % 4 == 0 && i != 0) {
        buffer.write("  ");
      }
      buffer.write(this[i]);
    }

    return buffer.toString();
  }

  /// Method that returns a formatted String of the card user
  String formattedCard() => length % 4 != 0
      ? "**** **** **** ****"
      : replaceAllMapped(RegExp(".{4}"), (match) => "${match.group(0)} ")
          .trim();
}
