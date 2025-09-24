import "../localization/l10n.dart";
import "app_exception.dart";
import "connection/http_call_exception.dart";

/// The abstract class for the failures in the application
abstract class Failure {
  /// The abstract class for the failures in the application
  Failure({required this.message, required this.title});

  /// The message of the error
  final String message;

  /// The title of the error
  final String title;
}

/// The levels of the failures
enum FailureLevel {
  /// Crtical error
  error,

  /// Warning error
  warning,

  /// Information error
  info,
}

/// Failure for the Http calls
class HttpCallFailure extends Failure {
  /// Failure for the Http calls
  HttpCallFailure({
    required super.message,
    required super.title,
    required this.type,
    this.data,
    this.code,
  });

  /// Create a [HttpCallFailure] from a [HttpCallException]
  factory HttpCallFailure.fromException(HttpCallException exception) =>
      HttpCallFailure(
        title: exception.title,
        message: exception.message,
        type: exception.type,
        data: exception.data,
        code: (exception is ClientErrorException) ? exception.code : null,
      );

  /// The type of the exception
  final HttpExceptions type;

  /// The data of the exception
  final Map<String, dynamic>? data;

  /// code of the exception
  final int? code;
}

/// Failure used for the application side
class AppFailure extends Failure {
  /// Failure used for the application side
  AppFailure({required super.message, required super.title});

  /// Create an [AppFailure]
  ///
  /// [message] is the message of the error
  ///
  /// This is used when the error is unexpected
  factory AppFailure.unexpected(String message) => AppFailure(
    title: FlutterCommonLocalizations.current.errorUnexpected,
    message: message,
  );

  /// Create an [AppFailure]
  ///
  /// [errorMessage] is the message of the error
  ///
  /// This is used when the error is related to the environment
  factory AppFailure.environment({required EnvironmentException exception}) =>
      AppFailure(title: exception.title, message: exception.message);

  /// Create an [AppFailure]
  ///
  /// [exception] is the exception that was thrown
  ///
  /// This is used when the error is related to cache operations
  factory AppFailure.cacheException(CacheException exception) =>
      AppFailure(title: exception.title, message: exception.message);

  /// Create an [AppFailure]
  ///
  /// This exception is used for displaying form errors to the user
  factory AppFailure.invalidForm(String formErrors) => AppFailure(
    title: FlutterCommonLocalizations.current.formInvalidFailureTitle,
    message: formErrors,
  );
}
