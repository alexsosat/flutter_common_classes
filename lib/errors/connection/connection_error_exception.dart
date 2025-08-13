import "../../localization/l10n.dart";
import "http_call_exception.dart";

/// The Exception that is thrown if a connection error ocurrs.
class ConnectionErrorException extends HttpCallException {
  /// The constructor for the connection error general exception.
  ///
  /// Can receive a [message] and [extras] values that can be used to manage
  /// the exception.
  ConnectionErrorException({
    required super.title,
    super.message = "",
    super.type = HttpExceptions.connectionError,
  });

  /// The constructor for the server down exception.
  ///
  /// Can receive a [message] and [extras] values that can be used to manage
  /// the exception.
  factory ConnectionErrorException.serverDown({
    String? title,
    String? message,
    HttpExceptions type = HttpExceptions.serverDown,
  }) => ConnectionErrorException(
    title:
        title ?? FlutterCommonLocalizations.current.serverUnderMantainanceTitle,
    message: message ?? FlutterCommonLocalizations.current.tryAgainLater,
    type: type,
  );

  /// The constructor for the client offline exception.
  ///
  /// Can receive a [message] and [extras] values that can be used to manage
  /// the exception.
  factory ConnectionErrorException.clientOffline({
    String? title,
    String? message,
    HttpExceptions type = HttpExceptions.clientOffline,
  }) => ConnectionErrorException(
    title:
        title ??
        FlutterCommonLocalizations.current.internetConnectionUnavailableTitle,
    message:
        message ??
        FlutterCommonLocalizations.current.internetConnectionUnavailableMessage,
  );
}
