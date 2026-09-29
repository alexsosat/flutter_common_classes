import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

import "../helpers/fake_cubits.dart";
import "../helpers/fixtures.dart";

void main() {
  late DriveableCubit<String> cubit;

  setUp(() {
    cubit = DriveableCubit<String>();
  });

  tearDown(() => cubit.close());

  Future<void> pumpBuilder(
    WidgetTester tester, {
    Widget Function(String data)? onSuccess,
    Widget? onLoading,
    Widget Function(Failure failure)? onFailure,
    Widget? onEmpty,
    Widget? onInitial,
  }) => tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<DriveableCubit<String>>.value(
        value: cubit,
        child: CubitWidgetStateBuilder<DriveableCubit<String>, String>(
          onSuccess: onSuccess ?? (data) => Text(data),
          onLoading: onLoading,
          onFailure: onFailure,
          onEmpty: onEmpty,
          onInitial: onInitial,
        ),
      ),
    ),
  );

  group("CubitWidgetStateBuilder", () {
    testWidgets("initial: renders SizedBox.shrink by default", (
      tester,
    ) async {
      await pumpBuilder(tester);

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets("initial: renders the custom onInitial widget when provided", (
      tester,
    ) async {
      await pumpBuilder(tester, onInitial: const Text("custom initial"));

      expect(find.text("custom initial"), findsOneWidget);
    });

    testWidgets("loading: renders a centered adaptive progress indicator by default", (
      tester,
    ) async {
      await pumpBuilder(tester);
      cubit.emitState(StateMixin<String>.loading());
      await tester.pump();

      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );
    });

    testWidgets("loading: renders the custom onLoading widget when provided", (
      tester,
    ) async {
      await pumpBuilder(tester, onLoading: const Text("custom loading"));
      cubit.emitState(StateMixin<String>.loading());
      await tester.pump();

      expect(find.text("custom loading"), findsOneWidget);
    });

    testWidgets("success: calls onSuccess with the casted data", (
      tester,
    ) async {
      await pumpBuilder(tester);
      cubit.emitState(StateMixin<String>.success("hello"));
      await tester.pump();

      expect(find.text("hello"), findsOneWidget);
    });

    testWidgets(
      "success with an empty list routes to the empty branch end-to-end",
      (tester) async {
        final emptyListCubit = DriveableCubit<List<int>>();
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<DriveableCubit<List<int>>>.value(
              value: emptyListCubit,
              child: CubitWidgetStateBuilder<DriveableCubit<List<int>>, List<int>>(
                onSuccess: (data) => Text("count: ${data.length}"),
              ),
            ),
          ),
        );
        emptyListCubit.emitState(StateMixin<List<int>>.success(<int>[]));
        await tester.pump();

        expect(find.text("No hay información disponible"), findsOneWidget);
        expect(find.textContaining("count:"), findsNothing);

        await emptyListCubit.close();
      },
    );

    testWidgets("failure: renders the failure title by default", (
      tester,
    ) async {
      final failure = sampleAppFailure(title: "Boom title");
      await pumpBuilder(tester);
      cubit.emitState(StateMixin<String>.failure(failure));
      await tester.pump();

      expect(find.text("Boom title"), findsOneWidget);
    });

    testWidgets("failure: renders the custom onFailure widget with the exact failure", (
      tester,
    ) async {
      final failure = sampleAppFailure(title: "Boom title");
      Failure? received;
      await pumpBuilder(
        tester,
        onFailure: (f) {
          received = f;
          return const Text("custom failure");
        },
      );
      cubit.emitState(StateMixin<String>.failure(failure));
      await tester.pump();

      expect(find.text("custom failure"), findsOneWidget);
      expect(received, same(failure));
    });

    testWidgets("empty: renders the default empty text", (tester) async {
      await pumpBuilder(tester);
      cubit.emitState(StateMixin<String>.empty());
      await tester.pump();

      expect(find.text("No hay información disponible"), findsOneWidget);
    });

    testWidgets("empty: renders the custom onEmpty widget when provided", (
      tester,
    ) async {
      await pumpBuilder(tester, onEmpty: const Text("custom empty"));
      cubit.emitState(StateMixin<String>.empty());
      await tester.pump();

      expect(find.text("custom empty"), findsOneWidget);
    });
  });
}
