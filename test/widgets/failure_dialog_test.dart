import "package:confirm_alert/localization/l10n.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

import "../helpers/fixtures.dart";

void main() {
  Future<void> pumpTrigger(
    WidgetTester tester,
    Failure failure, {
    ConfirmationDialogOptions options = const ConfirmationDialogOptions(
      type: DialogType.warning,
      showCancel: false,
      barrierDismissible: false,
    ),
  }) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showFailureDialog(
              context: context,
              failure: failure,
              options: options,
            ),
            child: const Text("trigger"),
          ),
        ),
      ),
    ),
  );

  group("showFailureDialog", () {
    testWidgets("renders the failure's title and message", (tester) async {
      final failure = sampleAppFailure(
        title: "Dialog title",
        message: "Dialog message",
      );
      await pumpTrigger(tester, failure);

      await tester.tap(find.text("trigger"));
      await tester.pumpAndSettle();

      expect(find.text("Dialog title"), findsOneWidget);
      expect(find.text("Dialog message"), findsOneWidget);
    });

    testWidgets("default options hide the cancel button", (tester) async {
      await pumpTrigger(tester, sampleAppFailure());

      await tester.tap(find.text("trigger"));
      await tester.pumpAndSettle();

      expect(
        find.text(ConfirmAlertLocalizations.current.cancel),
        findsNothing,
      );
    });

    testWidgets("showCancel: true renders a cancel button", (tester) async {
      await pumpTrigger(
        tester,
        sampleAppFailure(),
        options: const ConfirmationDialogOptions(
          type: DialogType.warning,
          showCancel: true,
          barrierDismissible: false,
        ),
      );

      await tester.tap(find.text("trigger"));
      await tester.pumpAndSettle();

      expect(
        find.text(ConfirmAlertLocalizations.current.cancel),
        findsOneWidget,
      );
    });
  });
}
