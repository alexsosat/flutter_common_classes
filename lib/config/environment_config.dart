import "package:flutter/material.dart";
import "package:flutter_flavor/flutter_flavor.dart";

/// Contract that an app-specific flavor enum must implement so
/// [EnvironmentConfig] can configure it, regardless of how many flavors
/// the app defines or what they're named.
///
/// Each consuming app should declare its own enum, e.g.:
/// ```dart
/// enum Flavor implements AppFlavor {
///   mock(variables: {}),
///   test(variables: {'apiUrl': 'https://test.api'}),
///   production(variables: {'apiUrl': 'https://api'});
///
///   const Flavor({required this.variables});
///
///   @override
///   final Map<String, dynamic> variables;
/// }
/// ```
abstract interface class AppFlavor implements Enum {
  /// Configuration variables available for this flavor.
  Map<String, dynamic> get variables;
}

/// A class that provides the environment configuration for the application.
///
/// This class is used to set the environment variables for the application.
abstract class EnvironmentConfig {
  static AppFlavor? _current;
  static String _mockFlavorName = "mock";

  /// Initializes the environment configuration.
  ///
  /// [mockFlavorName] and [productionFlavorName] identify which of the
  /// app's flavor values are treated as the mock and production flavors,
  /// respectively. They default to "mock" and "production" to match the
  /// conventional flavor names.
  static void init({
    required AppFlavor flavor,
    String mockFlavorName = "mock",
    String productionFlavorName = "production",
  }) {
    _current = flavor;
    _mockFlavorName = mockFlavorName;

    FlavorConfig(
      name: flavor.name != productionFlavorName ? flavor.name : null,
      color: Colors.red,
      location: BannerLocation.topStart,
      variables: flavor.variables,
    );
  }

  /// Whether the current flavor is the mock flavor.
  static bool get isMockFlavor => _current?.name == _mockFlavorName;

  static AppFlavor get current => _current!;
}
