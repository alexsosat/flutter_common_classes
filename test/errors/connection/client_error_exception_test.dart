import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ClientErrorException", () {
    test("base constructor stores fields with clientError as default type", () {
      final exception = ClientErrorException(title: "title", code: 400);

      expect(exception.title, "title");
      expect(exception.message, "");
      expect(exception.type, HttpExceptions.clientError);
      expect(exception.code, 400);
    });

    test("unauthorized() uses localized defaults when not overridden", () {
      final exception = ClientErrorException.unauthorized();

      expect(
        exception.title,
        FlutterCommonLocalizations.current.userUnauthorizedTitle,
      );
      expect(
        exception.message,
        FlutterCommonLocalizations.current.userUnauthorizedMessage,
      );
      expect(exception.type, HttpExceptions.unauthorized);
    });

    test("unauthorized() honors explicit title/message overrides", () {
      final exception = ClientErrorException.unauthorized(
        title: "custom title",
        message: "custom message",
        code: 401,
      );

      expect(exception.title, "custom title");
      expect(exception.message, "custom message");
      expect(exception.code, 401);
    });

    test("notFound() uses localized route-not-found defaults", () {
      final exception = ClientErrorException.notFound();

      expect(exception.title, FlutterCommonLocalizations.current.routeNotFound);
      expect(
        exception.message,
        FlutterCommonLocalizations.current.routeNotFoundMessage,
      );
      expect(exception.type, HttpExceptions.notFound);
    });

    test("badRequest() uses localized bad-request defaults", () {
      final exception = ClientErrorException.badRequest();

      expect(exception.title, FlutterCommonLocalizations.current.requestBadTitle);
      expect(
        exception.message,
        FlutterCommonLocalizations.current.requestBadMessage,
      );
      expect(exception.type, HttpExceptions.badRequest);
    });

    test("cancelRequest() uses localized cancel defaults", () {
      final exception = ClientErrorException.cancelRequest();

      expect(
        exception.title,
        FlutterCommonLocalizations.current.requestCanceledTitle,
      );
      expect(
        exception.message,
        FlutterCommonLocalizations.current.requestCanceledMessage,
      );
      expect(exception.type, HttpExceptions.cancelRequest);
    });

    test(
      "expiredToken() uses localized session-expired defaults and always "
      "reports HttpExceptions.expiredToken regardless of the type argument "
      "(documented quirk: the factory ignores its own `type` parameter)",
      () {
        final exception = ClientErrorException.expiredToken(
          type: HttpExceptions.badRequest,
        );

        expect(
          exception.title,
          FlutterCommonLocalizations.current.sessionExpiredTitle,
        );
        expect(
          exception.message,
          FlutterCommonLocalizations.current.sessionExpiredMessage,
        );
        expect(exception.type, HttpExceptions.expiredToken);
      },
    );
  });
}
