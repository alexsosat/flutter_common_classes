import 'package:flutter_common_classes/cubit_states/state_mixin.dart';
import 'package:flutter_common_classes/cubits/loader_cubit.dart';
import 'package:flutter_common_classes/errors/failure.dart';
import 'package:flutter_common_classes/extensions/cubit_extension.dart';
import 'package:flutter_common_classes/localization/l10n.dart';
import 'package:fpdart/fpdart.dart';

abstract class ValueLoaderCubit<T, J> extends LoaderCubit<T> {
  ValueLoaderCubit() : super(StateMixin.initial());

  J? value;

  /// Fetch the information from a use case
  @override
  Future<Either<Failure, T>> getInfo() async {
    try {
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

      return await super.getInfo();
    } catch (e) {
      final failure = AppFailure.unexpected(e.toString());
      safeEmit(StateMixin.failure(failure));

      return Left(failure);
    }
  }

  void setValue(J value) {
    this.value = value;
  }

  /// Sets the value and refreshes the information
  void setValueAndRefresh(J value) {
    setValue(value);
    getInfo();
  }
}
