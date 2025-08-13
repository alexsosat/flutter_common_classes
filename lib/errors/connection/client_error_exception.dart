import "../../localization/l10n.dart";
import "http_call_exception.dart";

/// The Exception that is thrown if a client error ocurrs.
class ClientErrorException extends HttpCallException {
  /// The constructor for the client error general exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  ClientErrorException({
    required super.title,
    super.data,
    super.message = "",
    super.type = HttpExceptions.clientError,
  });

  /// The constructor for the unauthorized exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  factory ClientErrorException.unauthorized({
    String? title,
    String? message,
    Map<String, dynamic>? data,
    HttpExceptions type = HttpExceptions.unauthorized,
  }) {
    return ClientErrorException(
      title: title ?? FlutterCommonLocalizations.current.userUnauthorizedTitle,
      message:
          message ?? FlutterCommonLocalizations.current.userUnauthorizedMessage,
      data: data,
      type: type,
    );
  }

  /// The constructor for the expired token exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  factory ClientErrorException.expiredToken({
    String? title,
    String? message,
    Map<String, dynamic>? data,
    HttpExceptions type = HttpExceptions.expiredToken,
  }) => ClientErrorException(
    title: title ?? FlutterCommonLocalizations.current.sessionExpiredTitle,
    message:
        message ?? FlutterCommonLocalizations.current.sessionExpiredMessage,
    type: HttpExceptions.expiredToken,
  );

  /// The constructor for the Bad Request exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  factory ClientErrorException.badRequest({
    String? title,
    String? message,
    Map<String, dynamic>? data,
    HttpExceptions type = HttpExceptions.badRequest,
  }) => ClientErrorException(
    title: title ?? FlutterCommonLocalizations.current.requestBadTitle,
    message: message ?? FlutterCommonLocalizations.current.requestBadMessage,
    data: data,
    type: type,
  );

  /// The constructor for the cancel exception.
  factory ClientErrorException.cancelRequest({
    String? title,
    String? message,
    Map<String, dynamic>? data,
    HttpExceptions type = HttpExceptions.cancelRequest,
  }) => ClientErrorException(
    title: title ?? FlutterCommonLocalizations.current.requestCanceledTitle,
    message:
        message ?? FlutterCommonLocalizations.current.requestCanceledMessage,
    data: data,
    type: type,
  );
}
