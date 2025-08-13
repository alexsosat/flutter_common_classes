import "package:flutter_bloc/flutter_bloc.dart";
import "package:fpdart/fpdart.dart";

import "../flutter_common_classes.dart";
import "../localization/l10n.dart";

/// Base cubit for getting information from a use case
abstract class GetInfoByValueCubit<T, J> extends Cubit<StateMixin<T>> {
  /// Base cubit for getting information from a use case
  GetInfoByValueCubit() : super(StateMixin.initial());

  /// The value to use as an identifier for the retrieval of the information
  J? value;

  /// Fetch the information from a use case
  Future<Either<Failure, T>> getInfo() async {
    try {
      safeEmit(StateMixin.loading());

      if (value == null) {
        safeEmit(StateMixin.initial());

        return Left(
          AppFailure(
            title: FlutterCommonLocalizations.current.valueNotSetFailureTitle,
            message:
                FlutterCommonLocalizations.current.valueNotSetFailureMessage,
          ),
        );
      }

      final response = await callUseCase();

      response.fold(
        (failure) => safeEmit(StateMixin.failure(failure)),
        (data) => safeEmit(StateMixin.success(data)),
      );

      return response;
    } catch (e) {
      final failure = AppFailure.unexpected(e.toString());
      safeEmit(StateMixin.failure(failure));

      return Left(failure);
    }
  }

  /// Use case to call
  Future<Either<Failure, T>> callUseCase();

  /// Sets the value and refreshes the information
  void setValueAndRefresh(J value) {
    this.value = value;
    getInfo();
  }
}
