import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../cubits/loader_cubit.dart';
import '../errors/failure.dart';
import '../helpers/loading_style.dart';
import '../localization/l10n.dart';
import '../widgets/cubit_widget_state_builder.dart';
import 'failure_view.dart';

abstract class PageLoaderWidget<T extends LoaderCubit<B>, B>
    extends StatelessWidget {
  const PageLoaderWidget({super.key});

  /// Main cubit that manages the data loading process.
  T get mainCubit;

  /// The style of the loading widget.
  LoadingStyle get loadingStyle => NormalLoadingStyle();

  /// Widget to show when an error occurs.
  Widget errorWidget(BuildContext context, Failure failure) => CustomScrollView(
    slivers: [
      SliverFillRemaining(hasScrollBody: false, child: FailureView(failure)),
    ],
  );

  /// Widget to show when empty.
  Widget emptyWidget(BuildContext context) => CustomScrollView(
    slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(FlutterCommonLocalizations.current.noData)),
      ),
    ],
  );

  /// Widget to show when the page is on its initial state.
  Widget get initialWidget => SizedBox.shrink();

  /// Other [Bloc]s to provide to the [MultiBlocProvider]
  List<BlocProvider>? get cubits => null;

  /// Display your widget.
  Widget view(BuildContext context, B data) {
    throw UnimplementedError();
  }

  Widget? pageScaffold(Widget child) => null;

  @override
  Widget build(BuildContext context) {
    final content = _ContentLoader(
      cubit: mainCubit,
      loadingStyle: loadingStyle,
      view: view,
      errorWidget: errorWidget,
      initialWidget: initialWidget,
      emptyWidget: emptyWidget,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => mainCubit),
        ...cubits ?? [],
      ],
      child: pageScaffold(content) ?? Scaffold(body: content),
    );
  }
}

class _ContentLoader<T extends LoaderCubit<B>, B> extends StatelessWidget {
  const _ContentLoader({
    required this.cubit,
    required this.loadingStyle,
    required this.view,
    required this.errorWidget,
    required this.initialWidget,
    required this.emptyWidget,
  });

  final T cubit;

  final LoadingStyle loadingStyle;

  final Widget Function(BuildContext context, Failure failure) errorWidget;

  final Widget Function(BuildContext context, B data) view;

  final Widget initialWidget;

  final Widget Function(BuildContext context) emptyWidget;

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
    onRefresh: () => context.read<T>().getInfo(),
    child: CubitWidgetStateBuilder<T, B>(
      onSuccess: (data) => view(context, data),
      onLoading: _getLoadingWidget(context),
      onFailure: (failure) => errorWidget(context, failure),
      onInitial: initialWidget,
      onEmpty: emptyWidget(context),
    ),
  );

  Widget? _getLoadingWidget(BuildContext context) {
    if (loadingStyle is NormalLoadingStyle) {
      return loadingStyle.render();
    } else if (loadingStyle is SkeletonizerLoadingStyle) {
      final skeletonLoadingStyle = loadingStyle as SkeletonizerLoadingStyle;

      return Skeletonizer(
        enabled: true,
        effect: skeletonLoadingStyle.effect.getEffect(),
        child:
            loadingStyle.child ?? view(context, skeletonLoadingStyle.mockData),
      );
    } else {
      return loadingStyle.render();
    }
  }
}
