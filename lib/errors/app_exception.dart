import '../localization/l10n.dart';

/// Exception class for the application.
///
/// This class is used to handle the exceptions in the application.
class AppException implements Exception {
  /// Exception class for the application.
  ///
  /// This class is used to handle the exceptions in the application.
  AppException({required this.title, required this.message});

  /// The title of the exception.
  final String title;

  /// The message of the exception.
  final String message;
}

/// Exception thrown when a connection to the local database fails.
class CacheException extends AppException {
  /// Exception thrown when a connection to the local database fails.
  CacheException({required super.title, required super.message});

  factory CacheException.create() => CacheException(
    title: FlutterCommonLocalizations.current.cacheExceptionTitle,
    message: FlutterCommonLocalizations.current.tryAgainLater,
  );

  factory CacheException.fromException(Exception exception) => CacheException(
    title: FlutterCommonLocalizations.current.cacheExceptionTitle,
    message: exception.toString(),
  );

  factory CacheException.saveError(String token) => CacheException(
    title: FlutterCommonLocalizations.current.cacheExceptionTitle,
    message: FlutterCommonLocalizations.current.saveValueError(token),
  );

  factory CacheException.deleteError(String token) => CacheException(
    title: FlutterCommonLocalizations.current.cacheExceptionTitle,
    message: FlutterCommonLocalizations.current.deleteValueError(token),
  );

  factory CacheException.readError(String token) => CacheException(
    title: FlutterCommonLocalizations.current.cacheExceptionTitle,
    message: FlutterCommonLocalizations.current.readValueError(token),
  );
}

/// Exception thrown when a connection with the environment fails.
class EnvironmentException extends AppException {
  /// Exception thrown when a connection with the environment fails.
  EnvironmentException({required super.title, required super.message});

  factory EnvironmentException.create(String token) => EnvironmentException(
    title: FlutterCommonLocalizations.current.environmentExceptionTitle,
    message: FlutterCommonLocalizations.current.environmentExceptionMessage(
      token,
    ),
  );
}
