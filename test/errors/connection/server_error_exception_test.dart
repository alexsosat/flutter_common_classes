import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ServerErrorException", () {
    test("base constructor defaults type to serverError", () {
      final exception = ServerErrorException(title: "title", message: "message");

      expect(exception.title, "title");
      expect(exception.message, "message");
      expect(exception.type, HttpExceptions.serverError);
    });

    test(
      "badCertificate() uses localized certificate-invalid defaults and "
      "defaults its own `type` parameter to HttpExceptions.badRequest, not "
      "HttpExceptions.badCertificate (documented quirk)",
      () {
        final exception = ServerErrorException.badCertificate();

        expect(
          exception.title,
          FlutterCommonLocalizations.current.certificateInvalidTitle,
        );
        expect(
          exception.message,
          FlutterCommonLocalizations.current.certificateInvalidMessage,
        );
        expect(exception.type, HttpExceptions.badRequest);
      },
    );

    test("badCertificate() honors an explicit type override", () {
      final exception = ServerErrorException.badCertificate(
        type: HttpExceptions.badCertificate,
      );

      expect(exception.type, HttpExceptions.badCertificate);
    });

    test("badCertificate() honors explicit title/message overrides", () {
      final exception = ServerErrorException.badCertificate(
        title: "custom",
        message: "custom message",
      );

      expect(exception.title, "custom");
      expect(exception.message, "custom message");
    });
  });
}
