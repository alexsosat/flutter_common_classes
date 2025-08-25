import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

import "../flutter_common_classes.dart";

/// Widget that shows a [Failure] in a page.
///
/// Shows the user that an error occurred and allows them to retry the action.
class FailureView extends StatelessWidget {
  /// Widget that shows a [Failure] in a page.
  ///
  /// Shows the user that an error occurred and allows them to retry the action.
  const FailureView(this.failure, {super.key, this.onRetry});

  /// The [Failure] to show in the page,
  final Failure failure;

  /// The [Function] to call when the user wants to retry the action.
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: _FailureAnimation(failure: failure),
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 25, right: 25),
                child: Text(
                  failure.title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 25, right: 25),
                child: Text(
                  failure.message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        if (onRetry != null)
          Flexible(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
              ),
              child: Text("Reintentar".toCapitalized()),
              onPressed: () {
                onRetry?.call();
              },
            ),
          ),
      ],
    ),
  );
}

class _FailureAnimation extends StatelessWidget {
  const _FailureAnimation({required this.failure});

  /// The [Failure] to show in the animation.
  final Failure failure;

  @override
  Widget build(BuildContext context) => Lottie.asset(
    switch (failure) {
      AppFailure _ => "assets/animations/failure/app_error.json",
      HttpCallFailure serverErrorFailure => _httpAnimation(
        serverErrorFailure.type,
      ),
      _ => "assets/animations/failure/unexpected.json",
    },
    // TODO: Validate the animation loading
    package: "flutter_common_classes",
  );

  String _httpAnimation(HttpExceptions type) {
    switch (type) {
      case HttpExceptions.connectionError:
      case HttpExceptions.clientOffline:
        return "assets/animations/failure/no_internet.json";
      case HttpExceptions.serverDown:
      case HttpExceptions.serverError:
        return "assets/animations/failure/server_error.json";
      case HttpExceptions.unauthorized:
      case HttpExceptions.expiredToken:
        return "assets/animations/failure/unauthorized.json";
      case HttpExceptions.clientError:
      case HttpExceptions.badRequest:
        return "assets/animations/failure/bad_request.json";
      case HttpExceptions.cancelRequest:
        return "assets/animations/failure/canceled.json";
      case HttpExceptions.badCertificate:
        return "assets/animations/failure/bad_certificate.json";
      case HttpExceptions.other:
        return "assets/animations/failure/unexpected.json";
    }
  }
}
