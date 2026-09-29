import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/widgets/cubit_skeletonizer_state_builder.dart";
import "package:flutter_test/flutter_test.dart";
import "package:skeletonizer/skeletonizer.dart";

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
    Widget Function(Failure failure)? onFailure,
    Widget? onEmpty,
    Widget? onInitial,
  }) => tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<DriveableCubit<String>>.value(
        value: cubit,
        child: CubitSkeletonizerStateBuilder<DriveableCubit<String>, String>(
          onSuccess: onSuccess ?? (data) => Text(data),
          onLoading: SkeletonizerLoader<String>(
            mock: "mock data",
            widget: (data) => Text(data),
          ),
          onFailure: onFailure,
          onEmpty: onEmpty,
          onInitial: onInitial,
        ),
      ),
    ),
  );

  group("CubitSkeletonizerStateBuilder", () {
    testWidgets("initial: renders SizedBox.shrink by default", (
      tester,
    ) async {
      await pumpBuilder(tester);

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets("loading: wraps the loader widget in an enabled Skeletonizer", (
      tester,
    ) async {
      await pumpBuilder(tester);
      cubit.emitState(StateMixin<String>.loading());
      await tester.pump();

      // `Skeletonizer(...)` is a `const factory` on an abstract class that
      // returns a private `_Skeletonizer` subclass, so `find.byType` (exact
      // runtime-type match) won't find it — match by `is Skeletonizer`
      // instead.
      final skeletonizerFinder = find.byWidgetPredicate(
        (widget) => widget is Skeletonizer,
      );
      expect(skeletonizerFinder, findsOneWidget);
      final skeletonizer = tester.widget<Skeletonizer>(skeletonizerFinder);
      expect(skeletonizer.enabled, isTrue);
      expect(find.text("mock data"), findsOneWidget);
    });

    testWidgets("success: calls onSuccess with the casted data", (
      tester,
    ) async {
      await pumpBuilder(tester);
      cubit.emitState(StateMixin<String>.success("hello"));
      await tester.pump();

      expect(find.text("hello"), findsOneWidget);
    });

    testWidgets("failure: renders the failure title by default", (
      tester,
    ) async {
      final failure = sampleAppFailure(title: "Boom title");
      await pumpBuilder(tester);
      cubit.emitState(StateMixin<String>.failure(failure));
      await tester.pump();

      expect(find.text("Boom title"), findsOneWidget);
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
