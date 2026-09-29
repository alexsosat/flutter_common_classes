// ignore_for_file: deprecated_member_use_from_same_package

import "package:flutter_common_classes/flutter_common_classes.dart";

/// Concrete [LoaderCubit] test double: forwards `callUseCase()` to an
/// injected mock so tests can control its result via mocktail.
class TestLoaderCubit<T> extends LoaderCubit<T> {
  TestLoaderCubit(this.useCase, {StateMixin<T>? initialState})
    : super(initialState ?? StateMixin<T>.initial());

  final UseCaseAsync<T, NoParams> useCase;

  @override
  Future<Either<Failure, T>> callUseCase() =>
      useCase.call(params: const NoParams());
}

/// Concrete [AutoLoaderCubit] test double.
class TestAutoLoaderCubit<T> extends AutoLoaderCubit<T> {
  TestAutoLoaderCubit(this.useCase);

  final UseCaseAsync<T, NoParams> useCase;

  @override
  Future<Either<Failure, T>> callUseCase() =>
      useCase.call(params: const NoParams());
}

/// Concrete [GetInfoCubit] test double.
class TestGetInfoCubit<T> extends GetInfoCubit<T> {
  TestGetInfoCubit(this.useCase);

  final UseCaseAsync<T, NoParams> useCase;

  @override
  Future<Either<Failure, T>> callUseCase() =>
      useCase.call(params: const NoParams());
}

/// Concrete [GetInfoByValueCubit] test double.
class TestGetInfoByValueCubit<T, J> extends GetInfoByValueCubit<T, J> {
  TestGetInfoByValueCubit(this.useCase);

  final UseCaseAsync<T, NoParams> useCase;

  @override
  Future<Either<Failure, T>> callUseCase() =>
      useCase.call(params: const NoParams());
}

/// Concrete [ValueLoaderCubit] test double.
class TestValueLoaderCubit<T, J> extends ValueLoaderCubit<T, J> {
  TestValueLoaderCubit(this.useCase);

  final UseCaseAsync<T, NoParams> useCase;

  @override
  Future<Either<Failure, T>> callUseCase() =>
      useCase.call(params: const NoParams());
}

/// A plain [Cubit] with a public [emitState] wrapper, used to drive the
/// state-builder widgets in widget tests without trying to mocktail-mock the
/// stream-based [Cubit] contract.
class DriveableCubit<T> extends Cubit<StateMixin<T>> {
  DriveableCubit([StateMixin<T>? initial])
    : super(initial ?? StateMixin<T>.initial());

  void emitState(StateMixin<T> state) => emit(state);
}
