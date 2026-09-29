// ignore_for_file: deprecated_member_use_from_same_package

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

  group("GetInfoByValueCubit (deprecated, still public API)", () {
    // Unlike ValueLoaderCubit, this cubit unconditionally emits `loading`
    // before checking `value`, so the "value not set" path still produces
    // two real, distinct-shape emissions: loading -> initial.
    blocTest<TestGetInfoByValueCubit<String, int>, StateMixin<String>>(
      "value not set: emits [loading, initial], returns a "
      "'value not set' failure, and never calls the use case",
      build: () => TestGetInfoByValueCubit<String, int>(useCase),
      act: (cubit) => cubit.getInfo(),
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.initial(),
      ],
      verify: (_) {
        verifyNever(() => useCase.call(params: any(named: "params")));
      },
    );

    test("value not set: getInfo() resolves to the 'value not set' failure", () async {
      final cubit = TestGetInfoByValueCubit<String, int>(useCase);

      final result = await cubit.getInfo();

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
      await cubit.close();
    });

    blocTest<TestGetInfoByValueCubit<String, int>, StateMixin<String>>(
      "value set directly: emits [loading, success] and calls the use case",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestGetInfoByValueCubit<String, int>(useCase),
      act: (cubit) {
        cubit.value = 5;
        return cubit.getInfo();
      },
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.success("data"),
      ],
      verify: (_) {
        verify(() => useCase.call(params: const NoParams())).called(1);
      },
    );

    blocTest<TestGetInfoByValueCubit<String, int>, StateMixin<String>>(
      "setValueAndRefresh() sets the value and fetches",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestGetInfoByValueCubit<String, int>(useCase),
      act: (cubit) => cubit.setValueAndRefresh(5),
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.success("data"),
      ],
      verify: (cubit) {
        expect(cubit.value, 5);
      },
    );

    // Runs both getInfo() calls inside blocTest's own `act`, letting
    // blocTest (rather than a hand-rolled `stream.listen`) handle the
    // microtask flushing needed to reliably observe every emission across
    // multiple sequential calls.
    blocTest<TestGetInfoByValueCubit<String, int>, StateMixin<String>>(
      "scenario: unset getInfo() then a value-set getInfo() drives the "
      "full loading -> initial -> loading -> success sequence",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestGetInfoByValueCubit<String, int>(useCase),
      act: (cubit) async {
        await cubit.getInfo();
        cubit.value = 5;
        await cubit.getInfo();
      },
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.initial(),
        StateMixin<String>.loading(),
        StateMixin<String>.success("data"),
      ],
    );
  });
}
