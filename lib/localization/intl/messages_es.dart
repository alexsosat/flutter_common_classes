// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(token) =>
      "Ocurrió un error al eliminar el valor de ${token}";

  static String m1(token) =>
      "Ocurrió un error al cargar la configuración de la app: ${token}";

  static String m2(token) => "Ocurrió un error al leer el valor de ${token}";

  static String m3(token) => "Ocurrió un error al guardar el valor: ${token}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cacheExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Error al acceder a información en el dispositivo",
    ),
    "certificateInvalidMessage": MessageLookupByLibrary.simpleMessage(
      "El certificado de seguridad del servidor no es válido",
    ),
    "certificateInvalidTitle": MessageLookupByLibrary.simpleMessage(
      "Certificado no válido",
    ),
    "deleteValueError": m0,
    "environmentExceptionMessage": m1,
    "environmentExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Error de ambiente",
    ),
    "errorUnexpected": MessageLookupByLibrary.simpleMessage(
      "Ocurrió un error en la aplicación",
    ),
    "formInvalidFailureTitle": MessageLookupByLibrary.simpleMessage(
      "Formulario inválido",
    ),
    "internetConnectionUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Revisa tu conexión a internet y vuelve a intentarlo",
        ),
    "internetConnectionUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Sin conexión a internet",
    ),
    "readValueError": m2,
    "requestBadMessage": MessageLookupByLibrary.simpleMessage(
      "Los parámetros enviados al servidor son incorrectos",
    ),
    "requestBadTitle": MessageLookupByLibrary.simpleMessage(
      "Petición incorrecta",
    ),
    "requestCanceledMessage": MessageLookupByLibrary.simpleMessage(
      "La petición fue cancelada por el usuario",
    ),
    "requestCanceledTitle": MessageLookupByLibrary.simpleMessage(
      "Petición cancelada",
    ),
    "routeNotFound": MessageLookupByLibrary.simpleMessage("Ruta no encontrada"),
    "routeNotFoundMessage": MessageLookupByLibrary.simpleMessage(
      "No se encontró el recurso solicitado",
    ),
    "saveValueError": m3,
    "search": MessageLookupByLibrary.simpleMessage("Buscar"),
    "serverUnderMantainanceTitle": MessageLookupByLibrary.simpleMessage(
      "Nuestros servidores se encuentran en mantenimiento",
    ),
    "sessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "La sesión ha expirado, por favor inicie sesión de nuevo",
    ),
    "sessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Sesión caducada",
    ),
    "tryAgainLater": MessageLookupByLibrary.simpleMessage(
      "Por favor intenta más tarde",
    ),
    "userUnauthorizedMessage": MessageLookupByLibrary.simpleMessage(
      "El usuario no tiene los permisos necesarios para acceder a esta pantalla",
    ),
    "userUnauthorizedTitle": MessageLookupByLibrary.simpleMessage(
      "Este usuario no tiene acceso a la pantalla",
    ),
    "valueNotSetFailureMessage": MessageLookupByLibrary.simpleMessage(
      "Por favor proporciona un valor para obtener la información",
    ),
    "valueNotSetFailureTitle": MessageLookupByLibrary.simpleMessage(
      "Ningún valor proporcionado",
    ),
  };
}
