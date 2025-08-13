// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(token) => "Ocorreu um erro ao eliminar o valor de ${token}";

  static String m1(token) =>
      "Ocorreu um erro ao carregar a configuração da aplicação: ${token}";

  static String m2(token) => "Ocorreu um erro ao ler o valor de ${token}";

  static String m3(token) => "Ocorreu um erro ao guardar o valor: ${token}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cacheExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Erro ao aceder a informações no dispositivo",
    ),
    "certificateInvalidMessage": MessageLookupByLibrary.simpleMessage(
      "O certificado de segurança do servidor é inválido",
    ),
    "certificateInvalidTitle": MessageLookupByLibrary.simpleMessage(
      "Certificado inválido",
    ),
    "deleteValueError": m0,
    "environmentExceptionMessage": m1,
    "environmentExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "Erro de ambiente",
    ),
    "formInvalidFailureTitle": MessageLookupByLibrary.simpleMessage(
      "Formulário inválido",
    ),
    "internetConnectionUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Verifique a sua ligação à Internet e tente novamente.",
        ),
    "internetConnectionUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Sem ligação à Internet",
    ),
    "readValueError": m2,
    "requestBadMessage": MessageLookupByLibrary.simpleMessage(
      "Os parâmetros enviados para o servidor estão incorrectos",
    ),
    "requestBadTitle": MessageLookupByLibrary.simpleMessage("Pedido incorreto"),
    "requestCanceledMessage": MessageLookupByLibrary.simpleMessage(
      "O pedido foi cancelado pelo utilizador",
    ),
    "requestCanceledTitle": MessageLookupByLibrary.simpleMessage(
      "Petição anulada",
    ),
    "saveValueError": m3,
    "serverUnderMantainanceTitle": MessageLookupByLibrary.simpleMessage(
      "Os nossos servidores estão em manutenção",
    ),
    "sessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "A sua sessão expirou, por favor inicie sessão novamente.",
    ),
    "sessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Sessão expirada",
    ),
    "tryAgainLater": MessageLookupByLibrary.simpleMessage(
      "Por favor, tente novamente mais tarde",
    ),
    "userUnauthorizedMessage": MessageLookupByLibrary.simpleMessage(
      "O utilizador não tem as permissões necessárias para aceder a este ecrã.",
    ),
    "userUnauthorizedTitle": MessageLookupByLibrary.simpleMessage(
      "Este utilizador não tem acesso ao ecrã",
    ),
  };
}
