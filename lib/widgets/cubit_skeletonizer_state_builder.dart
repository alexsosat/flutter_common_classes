import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:skeletonizer/skeletonizer.dart";

import "../cubit_states/state_mixin.dart";
import "../errors/failure.dart";

/// A widget that loads the state of a [StateStreamable] and shows different
/// widgets based on the state.
///
/// This widget uses [Skeletonizer] to show a loading state
class CubitSkeletonizerStateBuilder<T extends StateStreamable<StateMixin<B>>, B>
    extends StatelessWidget {
  /// A widget that loads the state of a [StateStreamable] and shows different
  /// widgets based on the state.
  const CubitSkeletonizerStateBuilder({
    required this.onSuccess,
    required this.onLoading,
    this.onFailure,
    this.onEmpty,
    this.onInitial,
    super.key,
  });

  /// The [Widget] to show when the state is [WidgetStatus.loading]
  ///
  /// This widget will be shown when the state is [WidgetStatus.loading]
  final SkeletonizerLoader<B> onLoading;

  /// The [Widget] to show when the state is [WidgetStatus.success]
  final Widget Function(B data) onSuccess;

  /// The [Widget] to show when the state is [WidgetStatus.failure]
  ///
  /// If not provided, a [Text] with the error message will be shown
  final Widget Function(Failure failure)? onFailure;

  /// The [Widget] to show when the state is [WidgetStatus.empty]
  ///
  /// If not provided, a [Text] with the message "No data found" will be shown
  final Widget? onEmpty;

  /// The [Widget] to show when the state is [WidgetStatus.initial]
  final Widget? onInitial;

  @override
  Widget build(BuildContext context) => BlocBuilder<T, StateMixin<B>>(
    builder: (context, state) {
      switch (state.status) {
        case WidgetStatus.initial:
          return onInitial ?? const SizedBox.shrink();
        case WidgetStatus.loading:
          return Skeletonizer(
            enabled: true,
            child: onLoading.widget(onLoading.mock),
          );
        case WidgetStatus.success:
          return onSuccess(state.data as B);
        case WidgetStatus.failure:
          return onFailure?.call(state.failure!) ??
              Text(state.failure?.title ?? "Ocurrió un error inesperado");
        case WidgetStatus.empty:
          return onEmpty ?? const Text("No hay información disponible");
      }
    },
  );
}

/// Loader helper for [CubitSkeletonizerStateBuilder]
class SkeletonizerLoader<T> {
  /// Mock data for the loader
  final T mock;

  /// Widget to show when the state is [WidgetStatus.loading]
  final Widget Function(T data) widget;

  /// Creates a new [SkeletonizerLoader]
  const SkeletonizerLoader({required this.mock, required this.widget});
}
