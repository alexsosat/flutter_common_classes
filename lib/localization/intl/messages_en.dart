// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(token) =>
      "An error occurred when deleting the value of ${token}";

  static String m1(token) =>
      "An error occurred while loading the app configuration: ${token}";

  static String m2(token) =>
      "An error occurred when reading the value of ${token}";

  static String m3(token) =>
      "An error occurred while saving the value: ${token}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cacheExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Error accessing information on the device",
    ),
    "certificateInvalidMessage": MessageLookupByLibrary.simpleMessage(
      "The server\'s security certificate is invalid",
    ),
    "certificateInvalidTitle": MessageLookupByLibrary.simpleMessage(
      "Invalid certificate",
    ),
    "deleteValueError": m0,
    "environmentExceptionMessage": m1,
    "environmentExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Environment error",
    ),
    "formInvalidFailureTitle": MessageLookupByLibrary.simpleMessage(
      "Invalid form",
    ),
    "internetConnectionUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Check your internet connection and try again.",
        ),
    "internetConnectionUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "readValueError": m2,
    "requestBadMessage": MessageLookupByLibrary.simpleMessage(
      "Parameters sent to the server are incorrect",
    ),
    "requestBadTitle": MessageLookupByLibrary.simpleMessage(
      "Incorrect request",
    ),
    "requestCanceledMessage": MessageLookupByLibrary.simpleMessage(
      "The request was cancelled by the user",
    ),
    "requestCanceledTitle": MessageLookupByLibrary.simpleMessage(
      "Request cancelled",
    ),
    "saveValueError": m3,
    "serverUnderMantainanceTitle": MessageLookupByLibrary.simpleMessage(
      "Our servers are under maintenance",
    ),
    "sessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "Your session has expired, please log in again.",
    ),
    "sessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Session expired",
    ),
    "tryAgainLater": MessageLookupByLibrary.simpleMessage(
      "Please try again later",
    ),
    "userUnauthorizedMessage": MessageLookupByLibrary.simpleMessage(
      "The user does not have the necessary permissions to access this screen.",
    ),
    "userUnauthorizedTitle": MessageLookupByLibrary.simpleMessage(
      "This user does not have access to the screen",
    ),
  };
}
