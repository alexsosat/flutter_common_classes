import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

import "../helpers/fixtures.dart";

void main() {
  Future<void> pumpFailureView(
    WidgetTester tester,
    Failure failure, {
    VoidCallback? onRetry,
  }) async {
    await tester.pumpWidget(
      MaterialApp(home: FailureView(failure, onRetry: onRetry)),
    );
    // Lottie animations can keep the pump loop perpetually "dirty"; bound
    // the pump instead of using an unconditional pumpAndSettle().
    await tester.pump(const Duration(milliseconds: 100));
  }

  group("FailureView", () {
    for (final failure in <Failure>[
      sampleAppFailure(),
      sampleHttpCallFailure(type: HttpExceptions.connectionError),
      sampleHttpCallFailure(type: HttpExceptions.clientOffline),
      sampleHttpCallFailure(type: HttpExceptions.serverDown),
      sampleHttpCallFailure(type: HttpExceptions.serverError),
      sampleHttpCallFailure(type: HttpExceptions.unauthorized),
      sampleHttpCallFailure(type: HttpExceptions.expiredToken),
      sampleHttpCallFailure(type: HttpExceptions.clientError),
      sampleHttpCallFailure(type: HttpExceptions.badRequest),
      sampleHttpCallFailure(type: HttpExceptions.cancelRequest),
      sampleHttpCallFailure(type: HttpExceptions.badCertificate),
      sampleHttpCallFailure(type: HttpExceptions.notFound),
      sampleHttpCallFailure(type: HttpExceptions.other),
    ]) {
      testWidgets(
        "renders title/message for a ${failure.runtimeType}"
        "${failure is HttpCallFailure ? ' (${failure.type})' : ''}",
        (tester) async {
          await pumpFailureView(tester, failure);

          expect(find.text(failure.title), findsOneWidget);
          expect(find.text(failure.message), findsOneWidget);
        },
      );
    }

    testWidgets("does not show a retry button when onRetry is null", (
      tester,
    ) async {
      await pumpFailureView(tester, sampleAppFailure());

      expect(find.text("Reintentar"), findsNothing);
    });

    testWidgets(
      "shows a retry button when onRetry is provided and taps invoke it",
      (tester) async {
        var tapped = false;
        await pumpFailureView(
          tester,
          sampleAppFailure(),
          onRetry: () => tapped = true,
        );

        expect(find.text("Reintentar"), findsOneWidget);

        await tester.tap(find.text("Reintentar"));
        await tester.pump();

        expect(tapped, isTrue);
      },
    );
  });
}
