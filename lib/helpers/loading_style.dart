import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

abstract class LoadingStyle {
  /// The widget to display as the loading widget.
  /// If null, the default loading widget will be displayed.
  final Widget? child;

  LoadingStyle(this.child);

  /// Render the loading widget.
  /// Provide a [child] to display a custom loading widget.
  /// If null, the default loading widget will be displayed.
  Widget render({Widget? child});
}

/// A [LoadingStyle] that displays a circular progress indicator.
class NormalLoadingStyle<T> extends LoadingStyle {
  /// Construct a [NormalLoadingStyle] widget.
  /// Provide a [child] to display a custom loading widget.
  NormalLoadingStyle({Widget? child}) : super(child);

  @override
  Widget render({Widget? child}) {
    return child ??
        this.child ??
        Center(child: const CircularProgressIndicator.adaptive());
  }
}

/// A [LoadingStyle] that displays a skeletonizer.
class SkeletonizerLoadingStyle<T> extends LoadingStyle {
  /// The effect to use for the skeletonizer.
  final SkeletonizerEffect effect;

  /// The mock data to display as the skeletonizer content.
  final T mockData;

  /// Construct a [SkeletonizerLoadingStyle] widget.
  /// Provide a [child] to display a custom loading widget.
  /// Optionally provide an [effect] to customize the skeleton animation.
  /// Optionally provide a [mockData] to display mock data.
  SkeletonizerLoadingStyle({
    Widget? child,
    required this.mockData,
    this.effect = SkeletonizerEffect.shimmer,
  }) : super(child);

  @override
  Widget render({Widget? child}) {
    return Skeletonizer(
      enabled: true,
      effect: effect.getEffect(),
      child:
          child ??
          this.child ??
          Center(child: const CircularProgressIndicator.adaptive()),
    );
  }
}

/// A [LoadingStyle] that displays no loading widget.
class NoneLoadingStyle<T> extends LoadingStyle {
  /// Construct a [NoneLoadingStyle] widget.
  /// Provide a [child] to display a custom loading widget.
  NoneLoadingStyle({required Widget? child}) : super(child);

  @override
  Widget render({Widget? child}) {
    return const SizedBox.shrink();
  }
}

/// The effect to use for the skeletonizer loading style
enum SkeletonizerEffect { shimmer, pulse, solid }

extension SkeletonizerEffectX on SkeletonizerEffect {
  /// Get the effect to use for the skeletonizer.
  PaintingEffect getEffect() {
    switch (this) {
      case SkeletonizerEffect.shimmer:
        return const ShimmerEffect();
      case SkeletonizerEffect.pulse:
        return const PulseEffect();
      case SkeletonizerEffect.solid:
        return const SolidColorEffect();
    }
  }
}
