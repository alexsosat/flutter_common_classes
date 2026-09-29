import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("AppException", () {
    test("stores title and message", () {
      final exception = AppException(title: "Title", message: "Message");

      expect(exception.title, "Title");
      expect(exception.message, "Message");
    });
  });

  group("CacheException", () {
    test("create() uses the cache exception title and 'try again later'", () {
      final exception = CacheException.create();

      expect(
        exception.title,
        FlutterCommonLocalizations.current.cacheExceptionTitle,
      );
      expect(exception.message, FlutterCommonLocalizations.current.tryAgainLater);
    });

    test("fromException() uses the exception's toString() as the message", () {
      final exception = CacheException.fromException(Exception("boom"));

      expect(
        exception.title,
        FlutterCommonLocalizations.current.cacheExceptionTitle,
      );
      expect(exception.message, "Exception: boom");
    });

    test("saveError() interpolates the token into the message", () {
      final exception = CacheException.saveError("auth_token");

      expect(
        exception.title,
        FlutterCommonLocalizations.current.cacheExceptionTitle,
      );
      expect(exception.message, contains("auth_token"));
      expect(
        exception.message,
        FlutterCommonLocalizations.current.saveValueError("auth_token"),
      );
    });

    test("deleteError() interpolates the token into the message", () {
      final exception = CacheException.deleteError("auth_token");

      expect(exception.message, contains("auth_token"));
      expect(
        exception.message,
        FlutterCommonLocalizations.current.deleteValueError("auth_token"),
      );
    });

    test("readError() interpolates the token into the message", () {
      final exception = CacheException.readError("auth_token");

      expect(exception.message, contains("auth_token"));
      expect(
        exception.message,
        FlutterCommonLocalizations.current.readValueError("auth_token"),
      );
    });
  });

  group("EnvironmentException", () {
    test("create() interpolates the token and uses the environment title", () {
      final exception = EnvironmentException.create("API_URL");

      expect(
        exception.title,
        FlutterCommonLocalizations.current.environmentExceptionTitle,
      );
      expect(exception.message, contains("API_URL"));
      expect(
        exception.message,
        FlutterCommonLocalizations.current.environmentExceptionMessage(
          "API_URL",
        ),
      );
    });
  });
}
