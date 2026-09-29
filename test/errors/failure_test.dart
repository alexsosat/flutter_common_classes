import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("HttpCallFailure", () {
    test("constructor stores all fields", () {
      final failure = HttpCallFailure(
        message: "message",
        title: "title",
        type: HttpExceptions.serverError,
        data: const {"key": "value"},
        code: 500,
      );

      expect(failure.message, "message");
      expect(failure.title, "title");
      expect(failure.type, HttpExceptions.serverError);
      expect(failure.data, {"key": "value"});
      expect(failure.code, 500);
    });

    test(
      "fromException() populates code from a ClientErrorException",
      () {
        final exception = ClientErrorException(
          title: "title",
          message: "message",
          code: 404,
        );

        final failure = HttpCallFailure.fromException(exception);

        expect(failure.title, "title");
        expect(failure.message, "message");
        expect(failure.type, exception.type);
        expect(failure.code, 404);
      },
    );

    test(
      "fromException() leaves code null for a non-ClientErrorException",
      () {
        final exception = ServerErrorException(
          title: "title",
          message: "message",
        );

        final failure = HttpCallFailure.fromException(exception);

        expect(failure.code, isNull);
      },
    );

    test(
      "fromException() leaves code null for a ConnectionErrorException",
      () {
        final exception = ConnectionErrorException(title: "title");

        final failure = HttpCallFailure.fromException(exception);

        expect(failure.code, isNull);
      },
    );
  });

  group("AppFailure", () {
    test("base constructor stores title and message", () {
      final failure = AppFailure(title: "title", message: "message");

      expect(failure.title, "title");
      expect(failure.message, "message");
    });

    test("unexpected() uses the generic error title", () {
      final failure = AppFailure.unexpected("boom");

      expect(
        failure.title,
        FlutterCommonLocalizations.current.errorUnexpected,
      );
      expect(failure.message, "boom");
    });

    test("environment() passes through the exception's title/message", () {
      final exception = EnvironmentException.create("API_URL");
      final failure = AppFailure.environment(exception: exception);

      expect(failure.title, exception.title);
      expect(failure.message, exception.message);
    });

    test("cacheException() passes through the exception's title/message", () {
      final exception = CacheException.create();
      final failure = AppFailure.cacheException(exception);

      expect(failure.title, exception.title);
      expect(failure.message, exception.message);
    });

    test("invalidForm() uses the invalid-form title with the given message", () {
      final failure = AppFailure.invalidForm("field is required");

      expect(
        failure.title,
        FlutterCommonLocalizations.current.formInvalidFailureTitle,
      );
      expect(failure.message, "field is required");
    });
  });
}
