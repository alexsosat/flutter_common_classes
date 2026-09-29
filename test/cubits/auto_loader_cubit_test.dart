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

  group("AutoLoaderCubit", () {
    test("starts synchronously in WidgetStatus.loading right after construction", () {
      when(
        () => useCase.call(params: any(named: "params")),
      ).thenAnswer((_) async => const Right("data"));

      final cubit = TestAutoLoaderCubit<String>(useCase);

      expect(cubit.state.status, WidgetStatus.loading);
      cubit.close();
    });

    // `getInfo()` fires synchronously from the constructor's body, which
    // runs (including its `safeEmit(StateMixin.loading())` call) before
    // `blocTest`/any test can attach a stream listener — `build()` has to
    // return the already-constructed cubit before subscription happens. So
    // that first `safeEmit` — the cubit's very first ever `emit()` call, one
    // `bloc` always lets through regardless of equality to the constructor's
    // state — is invisible to the test. Only the later terminal emit reaches
    // the listener.
    blocTest<TestAutoLoaderCubit<String>, StateMixin<String>>(
      "emits only [success] on the terminal state; the constructor's own "
      "loading emit happens before the test can subscribe",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestAutoLoaderCubit<String>(useCase),
      expect: () => [StateMixin<String>.success("data")],
      verify: (_) {
        verify(() => useCase.call(params: const NoParams())).called(1);
      },
    );

    final failure = AppFailure(title: "Oops", message: "failed");
    blocTest<TestAutoLoaderCubit<String>, StateMixin<String>>(
      "emits only [failure] when the use case returns a Left",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => Left(failure));
      },
      build: () => TestAutoLoaderCubit<String>(useCase),
      expect: () => [StateMixin<String>.failure(failure)],
    );

    blocTest<TestAutoLoaderCubit<String>, StateMixin<String>>(
      "emits only [failure] mapped to AppFailure.unexpected when the use "
      "case throws",
      setUp: () {
        // A synchronous `thenThrow` would throw (and the constructor's
        // fire-and-forget `getInfo()` would fully run its catch block)
        // before `blocTest` finishes subscribing to the stream, so the
        // emission would be missed. Answering asynchronously mirrors how a
        // real use case would actually reject its Future.
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => throw Exception("boom"));
      },
      build: () => TestAutoLoaderCubit<String>(useCase),
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
