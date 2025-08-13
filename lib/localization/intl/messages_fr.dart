// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(token) =>
      "Une erreur s\'est produite lors de la suppression de la valeur de ${token}";

  static String m1(token) =>
      "Une erreur s\'est produite lors du chargement de la configuration de l\'application : ${token}";

  static String m2(token) =>
      "Une erreur s\'est produite lors de la lecture de la valeur de ${token}";

  static String m3(token) =>
      "Une erreur s\'est produite lors de l\'enregistrement de la valeur : ${token}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cacheExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Erreur d\'accès aux informations sur l\'appareil",
    ),
    "certificateInvalidMessage": MessageLookupByLibrary.simpleMessage(
      "Le certificat de sécurité du serveur n\'est pas valide",
    ),
    "certificateInvalidTitle": MessageLookupByLibrary.simpleMessage(
      "Certificat invalide",
    ),
    "deleteValueError": m0,
    "environmentExceptionMessage": m1,
    "environmentExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Erreur d\'environnement",
    ),
    "formInvalidFailureTitle": MessageLookupByLibrary.simpleMessage(
      "Formulaire non valide",
    ),
    "internetConnectionUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Vérifiez votre connexion internet et réessayez.",
        ),
    "internetConnectionUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Pas de connexion internet",
    ),
    "readValueError": m2,
    "requestBadMessage": MessageLookupByLibrary.simpleMessage(
      "Les paramètres envoyés au serveur sont incorrects",
    ),
    "requestBadTitle": MessageLookupByLibrary.simpleMessage(
      "Demande incorrecte",
    ),
    "requestCanceledMessage": MessageLookupByLibrary.simpleMessage(
      "La demande a été annulée par l\'utilisateur",
    ),
    "requestCanceledTitle": MessageLookupByLibrary.simpleMessage(
      "Pétition annulée",
    ),
    "saveValueError": m3,
    "serverUnderMantainanceTitle": MessageLookupByLibrary.simpleMessage(
      "Nos serveurs sont en cours de maintenance",
    ),
    "sessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "Votre session a expiré, veuillez vous connecter à nouveau.",
    ),
    "sessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Session expirée",
    ),
    "tryAgainLater": MessageLookupByLibrary.simpleMessage(
      "Veuillez réessayer plus tard",
    ),
    "userUnauthorizedMessage": MessageLookupByLibrary.simpleMessage(
      "L\'utilisateur ne dispose pas des autorisations nécessaires pour accéder à cet écran.",
    ),
    "userUnauthorizedTitle": MessageLookupByLibrary.simpleMessage(
      "Cet utilisateur n\'a pas accès à l\'écran",
    ),
  };
}
