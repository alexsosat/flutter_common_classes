import "package:bloc_test/bloc_test.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/fake_cubits.dart";
import "../helpers/mocks.dart";

void main() {
  setUpAll(registerCommonFallbackValues);

  late MockUseCaseAsync<String, NoParams> useCase;

  setUp(() {
    useCase = MockUseCaseAsync<String, NoParams>();
  });

  group("ValueLoaderCubit.getInfo()", () {
    // ValueLoaderCubit starts in StateMixin.initial(), set directly by the
    // constructor (not via emit()), so the cubit's `_emitted` flag is still
    // false. `bloc` always lets the very first ever `emit()` call through,
    // even if it's equal to the constructor's state — this is `bloc`'s
    // documented "notify listeners of the initial state" allowance. So
    // calling `getInfo()` with `value == null` (whose only action is
    // `safeEmit(StateMixin.initial())`) is that first emit and DOES produce
    // one real stream event, not zero.
    test(
      "value not set: emits a single initial state (bloc's first-emit "
      "allowance), returns the 'value not set' failure, and the use case "
      "is never called",
      () async {
        final cubit = TestValueLoaderCubit<String, int>(useCase);
        final states = <StateMixin<String>>[];
        final subscription = cubit.stream.listen(states.add);

        final result = await cubit.getInfo();

        expect(states, [StateMixin<String>.initial()]);
        expect(cubit.state.status, WidgetStatus.initial);
        expect(result.isLeft(), isTrue);
        result.fold((failure) {
          expect(
            failure.title,
            FlutterCommonLocalizations.current.valueNotSetFailureTitle,
          );
          expect(
            failure.message,
            FlutterCommonLocalizations.current.valueNotSetFailureMessage,
          );
        }, (_) => fail("expected a Left"));
        verifyNever(() => useCase.call(params: any(named: "params")));

        await subscription.cancel();
        await cubit.close();
      },
    );

    blocTest<TestValueLoaderCubit<String, int>, StateMixin<String>>(
      "value set: emits [loading, success] by delegating to "
      "LoaderCubit.getInfo()",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestValueLoaderCubit<String, int>(useCase),
      act: (cubit) {
        cubit.setValue(5);
        return cubit.getInfo();
      },
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.success("data"),
      ],
    );

    final failure = AppFailure(title: "Oops", message: "failed");
    blocTest<TestValueLoaderCubit<String, int>, StateMixin<String>>(
      "value set: emits [loading, failure] when the use case returns a Left",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => Left(failure));
      },
      build: () => TestValueLoaderCubit<String, int>(useCase),
      act: (cubit) {
        cubit.setValue(5);
        return cubit.getInfo();
      },
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.failure(failure),
      ],
    );

    blocTest<TestValueLoaderCubit<String, int>, StateMixin<String>>(
      "value set: thrown exception is mapped to AppFailure.unexpected",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenThrow(Exception("boom"));
      },
      build: () => TestValueLoaderCubit<String, int>(useCase),
      act: (cubit) {
        cubit.setValue(5);
        return cubit.getInfo();
      },
      expect: () => [
        StateMixin<String>.loading(),
        isA<StateMixin<String>>()
            .having((s) => s.status, "status", WidgetStatus.failure)
            .having(
              (s) => s.failure?.title,
              "failure.title",
              FlutterCommonLocalizations.current.errorUnexpected,
            )
            .having(
              (s) => s.failure?.message,
              "failure.message",
              "Exception: boom",
            ),
      ],
    );

    test("setValue() only stores the value, without triggering a fetch", () async {
      final cubit = TestValueLoaderCubit<String, int>(useCase);
      final states = <StateMixin<String>>[];
      final subscription = cubit.stream.listen(states.add);

      cubit.setValue(5);

      expect(cubit.value, 5);
      expect(states, isEmpty);
      verifyNever(() => useCase.call(params: any(named: "params")));

      await subscription.cancel();
      await cubit.close();
    });

    blocTest<TestValueLoaderCubit<String, int>, StateMixin<String>>(
      "setValueAndRefresh() sets the value and fetches",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestValueLoaderCubit<String, int>(useCase),
      act: (cubit) => cubit.setValueAndRefresh(5),
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.success("data"),
      ],
      verify: (cubit) {
        expect(cubit.value, 5);
      },
    );
  });
}
