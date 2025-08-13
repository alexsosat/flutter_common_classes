// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(token) =>
      "Beim Löschen des Wertes von ${token} ist ein Fehler aufgetreten";

  static String m1(token) =>
      "Beim Laden der App-Konfiguration ist ein Fehler aufgetreten: ${token}";

  static String m2(token) =>
      "Beim Lesen des Wertes von ${token} ist ein Fehler aufgetreten";

  static String m3(token) =>
      "Beim Speichern des Wertes ist ein Fehler aufgetreten: ${token}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cacheExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Zugriff auf Informationen auf dem Gerät",
    ),
    "certificateInvalidMessage": MessageLookupByLibrary.simpleMessage(
      "Das Sicherheitszertifikat des Servers ist ungültig",
    ),
    "certificateInvalidTitle": MessageLookupByLibrary.simpleMessage(
      "Ungültiges Zertifikat",
    ),
    "deleteValueError": m0,
    "environmentExceptionMessage": m1,
    "environmentExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Fehler in der Umgebung",
    ),
    "formInvalidFailureTitle": MessageLookupByLibrary.simpleMessage(
      "Ungültiges Formular",
    ),
    "internetConnectionUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.",
        ),
    "internetConnectionUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Keine Internetverbindung",
    ),
    "readValueError": m2,
    "requestBadMessage": MessageLookupByLibrary.simpleMessage(
      "Die an den Server gesendeten Parameter sind falsch",
    ),
    "requestBadTitle": MessageLookupByLibrary.simpleMessage("Falscher Antrag"),
    "requestCanceledMessage": MessageLookupByLibrary.simpleMessage(
      "Die Anfrage wurde vom Benutzer abgebrochen",
    ),
    "requestCanceledTitle": MessageLookupByLibrary.simpleMessage(
      "Petition annulliert",
    ),
    "saveValueError": m3,
    "serverUnderMantainanceTitle": MessageLookupByLibrary.simpleMessage(
      "Unsere Server werden gerade gewartet",
    ),
    "sessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "Ihre Sitzung ist abgelaufen, bitte melden Sie sich erneut an.",
    ),
    "sessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Sitzung abgelaufen",
    ),
    "tryAgainLater": MessageLookupByLibrary.simpleMessage(
      "Bitte versuchen Sie es später noch einmal",
    ),
    "userUnauthorizedMessage": MessageLookupByLibrary.simpleMessage(
      "Der Benutzer verfügt nicht über die erforderlichen Berechtigungen für den Zugriff auf diesen Bildschirm.",
    ),
    "userUnauthorizedTitle": MessageLookupByLibrary.simpleMessage(
      "Dieser Benutzer hat keinen Zugriff auf den Bildschirm",
    ),
  };
}
