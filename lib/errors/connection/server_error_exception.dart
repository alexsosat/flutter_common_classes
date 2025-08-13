import "../../localization/l10n.dart";
import "http_call_exception.dart";

/// The Exception that is thrown if a server error ocurrs.
class ServerErrorException extends HttpCallException {
  /// The constructor for the server error general exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras
  /// values that can be used to manage the exception.
  ServerErrorException({
    required super.title,
    super.data,
    required super.message,
    super.type = HttpExceptions.serverError,
  });

  /// The constructor for the Bad Certificate exception.
  factory ServerErrorException.badCertificate({
    String? title,
    String? message,
    Map<String, dynamic>? data,
    HttpExceptions type = HttpExceptions.badRequest,
  }) => ServerErrorException(
    title: title ?? FlutterCommonLocalizations.current.certificateInvalidTitle,
    message:
        message ?? FlutterCommonLocalizations.current.certificateInvalidMessage,
    data: data,
    type: type,
  );
}
