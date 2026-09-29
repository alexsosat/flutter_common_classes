import "package:bloc_test/bloc_test.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/fake_cubits.dart";
import "../helpers/fixtures.dart";
import "../helpers/mocks.dart";

void main() {
  setUpAll(registerCommonFallbackValues);

  late MockUseCaseAsync<String, NoParams> useCase;

  setUp(() {
    useCase = MockUseCaseAsync<String, NoParams>();
  });

  group("LoaderCubit.getInfo()", () {
    blocTest<TestLoaderCubit<String>, StateMixin<String>>(
      "emits [loading, success] and resolves the use case's Right",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => const Right("data"));
      },
      build: () => TestLoaderCubit<String>(useCase),
      act: (cubit) => cubit.getInfo(),
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.success("data"),
      ],
      verify: (_) {
        verify(() => useCase.call(params: const NoParams())).called(1);
      },
    );

    final failure = sampleAppFailure();
    blocTest<TestLoaderCubit<String>, StateMixin<String>>(
      "emits [loading, failure] when the use case returns a Left",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenAnswer((_) async => Left(failure));
      },
      build: () => TestLoaderCubit<String>(useCase),
      act: (cubit) => cubit.getInfo(),
      expect: () => [
        StateMixin<String>.loading(),
        StateMixin<String>.failure(failure),
      ],
    );

    blocTest<TestLoaderCubit<String>, StateMixin<String>>(
      "emits [loading, failure] mapped to AppFailure.unexpected when the "
      "use case throws",
      setUp: () {
        when(
          () => useCase.call(params: any(named: "params")),
        ).thenThrow(Exception("boom"));
      },
      build: () => TestLoaderCubit<String>(useCase),
      act: (cubit) => cubit.getInfo(),
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

    test("returns Right(data) directly on success", () async {
      when(
        () => useCase.call(params: any(named: "params")),
      ).thenAnswer((_) async => const Right("data"));
      final cubit = TestLoaderCubit<String>(useCase);

      final result = await cubit.getInfo();

      expect(result, const Right<Failure, String>("data"));
      await cubit.close();
    });

    test("returns Left(failure) directly when the use case throws", () async {
      when(
        () => useCase.call(params: any(named: "params")),
      ).thenThrow(Exception("boom"));
      final cubit = TestLoaderCubit<String>(useCase);

      final result = await cubit.getInfo();

      expect(result.isLeft(), isTrue);
      await cubit.close();
    });
  });
}
