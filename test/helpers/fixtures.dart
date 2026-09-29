import "package:flutter_common_classes/flutter_common_classes.dart";

/// A representative [AppFailure] usable anywhere a plain failure fixture
/// is needed.
AppFailure sampleAppFailure({
  String title = "Something went wrong",
  String message = "Please try again",
}) => AppFailure(title: title, message: message);

/// A representative [HttpCallFailure] usable anywhere a network-flavored
/// failure fixture is needed.
HttpCallFailure sampleHttpCallFailure({
  HttpExceptions type = HttpExceptions.other,
  String title = "Network error",
  String message = "The request failed",
  int? code,
}) => HttpCallFailure(title: title, message: message, type: type, code: code);
