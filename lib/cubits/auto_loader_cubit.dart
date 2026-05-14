import 'package:flutter_common_classes/cubit_states/state_mixin.dart';
import 'package:flutter_common_classes/cubits/loader_cubit.dart';

/// Base cubit for loading data automatically
abstract class AutoLoaderCubit<T> extends LoaderCubit<T> {
  AutoLoaderCubit() : super(StateMixin.loading()) {
    getInfo();
  }
}
