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

  group("GetInfoCubit (deprecated, still public API)", () {
    test("starts synchronously in WidgetStatus.loading right after construction", () {
      when(
        () => useCase.call(params: any(named: "params")),
      ).thenAnswer((_) async => const Right("data"));

      final cubit = TestGetInfoCubit<String>(useCase);

      expect(cubit.state.status, WidgetStatus.loading);
      cubit.close();
    });

    blocTest<TestGetInfoCubit<String>, StateMixin<String>>(
      "emits only [success] on the terminal state; the constructor's own "
      "loading emit happens before the test can subscribe",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestGetInfoCubit<String>(useCase),
      expect: () => [StateMixin<String>.success("data")],
    );

    final failure = AppFailure(title: "Oops", message: "failed");
    blocTest<TestGetInfoCubit<String>, StateMixin<String>>(
      "emits only [failure] when the use case returns a Left",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => Left(failure));
      },
      build: () => TestGetInfoCubit<String>(useCase),
      expect: () => [StateMixin<String>.failure(failure)],
    );

    blocTest<TestGetInfoCubit<String>, StateMixin<String>>(
      "emits only [failure] mapped to AppFailure.unexpected when the use "
      "case throws",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => throw Exception("boom"));
      },
      build: () => TestGetInfoCubit<String>(useCase),
      expect: () => [
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
  });
}
