import "package:intl/intl.dart";

/// A set of useful extensions for the [DateTime] class.
extension DateExtension on DateTime {
  /// It returns a string in the [format] specified by the format parameter
  ///
  /// Args:
  ///   format (String): The format of the date string. Defaults to yyyy-MM-dd
  ///
  /// Returns:
  ///   A string
  String toStringFormat({String format = "yyyy-MM-dd"}) {
    final dateFormat = DateFormat(format);

    return dateFormat.format(this);
  }
}
