import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:shimmer/shimmer.dart";

/// A widget that displays a shimmer effect while loading.
class LoadingShimmer extends StatefulWidget {
  /// A widget that displays a shimmer effect while loading.
  const LoadingShimmer({
    this.width = 200,
    this.height = 20,
    this.borderRadius,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    super.key,
  });

  /// Defines the width of the shimmer.
  ///
  /// Default is `200`
  final double width;

  /// Defines the height of the shimmer.
  ///
  /// Default is `20`
  final double height;

  /// Defines the border radius of the shimmer.
  final BorderRadius? borderRadius;

  /// Defines the base color of the shimmer.
  final Color baseColor;

  /// Defines the highlight color of the shimmer.
  final Color highlightColor;

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: 1900.ms, vsync: this);
    _controller.addListener(_animationListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: widget.baseColor,
    highlightColor: widget.highlightColor,
    child: Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.baseColor,
        borderRadius: widget.borderRadius,
      ),
    ),
  ).animate(controller: _controller).fadeIn(duration: 700.ms);

  void _animationListener() {
    if (_controller.isCompleted) {
      Future.delayed(1300.ms).then((value) {
        if (mounted) {
          _controller.reverse();
        }
      });
    } else if (_controller.isDismissed) {
      Future.delayed(150.ms).then((value) {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }
}
