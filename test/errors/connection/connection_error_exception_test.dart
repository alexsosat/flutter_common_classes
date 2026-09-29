import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ConnectionErrorException", () {
    test("base constructor defaults message to empty and connectionError type", () {
      final exception = ConnectionErrorException(title: "title");

      expect(exception.title, "title");
      expect(exception.message, "");
      expect(exception.type, HttpExceptions.connectionError);
    });

    test("serverDown() uses localized maintenance defaults", () {
      final exception = ConnectionErrorException.serverDown();

      expect(
        exception.title,
        FlutterCommonLocalizations.current.serverUnderMantainanceTitle,
      );
      expect(exception.message, FlutterCommonLocalizations.current.tryAgainLater);
      expect(exception.type, HttpExceptions.serverDown);
    });

    test("serverDown() honors explicit title/message overrides", () {
      final exception = ConnectionErrorException.serverDown(
        title: "custom",
        message: "custom message",
      );

      expect(exception.title, "custom");
      expect(exception.message, "custom message");
    });

    test(
      "clientOffline() uses localized no-internet defaults, but leaves "
      "type at the base constructor's default of connectionError since the "
      "factory never forwards its own `type` parameter (documented quirk)",
      () {
        final exception = ConnectionErrorException.clientOffline();

        expect(
          exception.title,
          FlutterCommonLocalizations.current.internetConnectionUnavailableTitle,
        );
        expect(
          exception.message,
          FlutterCommonLocalizations
              .current
              .internetConnectionUnavailableMessage,
        );
        expect(exception.type, HttpExceptions.connectionError);
      },
    );
  });
}
