// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class FlutterCommonLocalizations {
  FlutterCommonLocalizations();

  static FlutterCommonLocalizations? _current;

  static FlutterCommonLocalizations get current {
    assert(
      _current != null,
      'No instance of FlutterCommonLocalizations was loaded. Try to initialize the FlutterCommonLocalizations delegate before accessing FlutterCommonLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<FlutterCommonLocalizations> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = FlutterCommonLocalizations();
      FlutterCommonLocalizations._current = instance;

      return instance;
    });
  }

  static FlutterCommonLocalizations of(BuildContext context) {
    final instance = FlutterCommonLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of FlutterCommonLocalizations present in the widget tree. Did you add FlutterCommonLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static FlutterCommonLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<FlutterCommonLocalizations>(
      context,
      FlutterCommonLocalizations,
    );
  }

  /// `Error al acceder a información en el dispositivo`
  String get cacheExceptionTitle {
    return Intl.message(
      'Error al acceder a información en el dispositivo',
      name: 'cacheExceptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `El certificado de seguridad del servidor no es válido`
  String get certificateInvalidMessage {
    return Intl.message(
      'El certificado de seguridad del servidor no es válido',
      name: 'certificateInvalidMessage',
      desc: '',
      args: [],
    );
  }

  /// `Certificado no válido`
  String get certificateInvalidTitle {
    return Intl.message(
      'Certificado no válido',
      name: 'certificateInvalidTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ocurrió un error al eliminar el valor de {token}`
  String deleteValueError(Object token) {
    return Intl.message(
      'Ocurrió un error al eliminar el valor de $token',
      name: 'deleteValueError',
      desc: '',
      args: [token],
    );
  }

  /// `Ocurrió un error al cargar la configuración de la app: {token}`
  String environmentExceptionMessage(Object token) {
    return Intl.message(
      'Ocurrió un error al cargar la configuración de la app: $token',
      name: 'environmentExceptionMessage',
      desc: '',
      args: [token],
    );
  }

  /// `Error de ambiente`
  String get environmentExceptionTitle {
    return Intl.message(
      'Error de ambiente',
      name: 'environmentExceptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ocurrió un error en la aplicación`
  String get errorUnexpected {
    return Intl.message(
      'Ocurrió un error en la aplicación',
      name: 'errorUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `Formulario inválido`
  String get formInvalidFailureTitle {
    return Intl.message(
      'Formulario inválido',
      name: 'formInvalidFailureTitle',
      desc: '',
      args: [],
    );
  }

  /// `Revisa tu conexión a internet y vuelve a intentarlo`
  String get internetConnectionUnavailableMessage {
    return Intl.message(
      'Revisa tu conexión a internet y vuelve a intentarlo',
      name: 'internetConnectionUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sin conexión a internet`
  String get internetConnectionUnavailableTitle {
    return Intl.message(
      'Sin conexión a internet',
      name: 'internetConnectionUnavailableTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ocurrió un error al leer el valor de {token}`
  String readValueError(Object token) {
    return Intl.message(
      'Ocurrió un error al leer el valor de $token',
      name: 'readValueError',
      desc: '',
      args: [token],
    );
  }

  /// `Los parámetros enviados al servidor son incorrectos`
  String get requestBadMessage {
    return Intl.message(
      'Los parámetros enviados al servidor son incorrectos',
      name: 'requestBadMessage',
      desc: '',
      args: [],
    );
  }

  /// `Petición incorrecta`
  String get requestBadTitle {
    return Intl.message(
      'Petición incorrecta',
      name: 'requestBadTitle',
      desc: '',
      args: [],
    );
  }

  /// `La petición fue cancelada por el usuario`
  String get requestCanceledMessage {
    return Intl.message(
      'La petición fue cancelada por el usuario',
      name: 'requestCanceledMessage',
      desc: '',
      args: [],
    );
  }

  /// `Petición cancelada`
  String get requestCanceledTitle {
    return Intl.message(
      'Petición cancelada',
      name: 'requestCanceledTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ocurrió un error al guardar el valor: {token}`
  String saveValueError(Object token) {
    return Intl.message(
      'Ocurrió un error al guardar el valor: $token',
      name: 'saveValueError',
      desc: '',
      args: [token],
    );
  }

  /// `Nuestros servidores se encuentran en mantenimiento`
  String get serverUnderMantainanceTitle {
    return Intl.message(
      'Nuestros servidores se encuentran en mantenimiento',
      name: 'serverUnderMantainanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `La sesión ha expirado, por favor inicie sesión de nuevo`
  String get sessionExpiredMessage {
    return Intl.message(
      'La sesión ha expirado, por favor inicie sesión de nuevo',
      name: 'sessionExpiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sesión caducada`
  String get sessionExpiredTitle {
    return Intl.message(
      'Sesión caducada',
      name: 'sessionExpiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Por favor intenta más tarde`
  String get tryAgainLater {
    return Intl.message(
      'Por favor intenta más tarde',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `El usuario no tiene los permisos necesarios para acceder a esta pantalla`
  String get userUnauthorizedMessage {
    return Intl.message(
      'El usuario no tiene los permisos necesarios para acceder a esta pantalla',
      name: 'userUnauthorizedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Este usuario no tiene acceso a la pantalla`
  String get userUnauthorizedTitle {
    return Intl.message(
      'Este usuario no tiene acceso a la pantalla',
      name: 'userUnauthorizedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Por favor proporciona un valor para obtener la información`
  String get valueNotSetFailureMessage {
    return Intl.message(
      'Por favor proporciona un valor para obtener la información',
      name: 'valueNotSetFailureMessage',
      desc: '',
      args: [],
    );
  }

  /// `Ningún valor proporcionado`
  String get valueNotSetFailureTitle {
    return Intl.message(
      'Ningún valor proporcionado',
      name: 'valueNotSetFailureTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<FlutterCommonLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<FlutterCommonLocalizations> load(Locale locale) =>
      FlutterCommonLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
