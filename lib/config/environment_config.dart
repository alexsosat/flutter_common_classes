import "package:flutter/material.dart";
import "package:flutter_flavor/flutter_flavor.dart";

/// A class that provides the environment configuration for the application.
///
/// This class is used to set the environment variables for the application.
abstract class EnvironmentConfig {
  /// Initializes the environment configuration.
  static void init({required Flavor flavor}) {
    FlavorConfig(
      name: flavor.name != "production" ? flavor.name : null,
      color: Colors.red,
      location: BannerLocation.topStart,
      variables: _getVariables(flavor),
    );
  }

  static Map<String, dynamic> _getVariables(Flavor flavor) => switch (flavor) {
    Flavor.mock => _mockVariables,
    Flavor.local => _localVariables,
    Flavor.test => _testVariables,
    Flavor.production => _prodVariables,
    Flavor.preProduction => _preProdVariables,
  };

  static const Map<String, dynamic> _mockVariables = {};

  static const Map<String, dynamic> _localVariables = {};

  static const Map<String, dynamic> _testVariables = {};

  static const Map<String, dynamic> _preProdVariables = {};

  static const Map<String, dynamic> _prodVariables = {};
}

/// The different environments for the application.
enum Flavor {
  /// The mock environment.
  mock,

  /// The local environment.
  local,

  /// The test environment.
  test,

  /// The pre production environment.
  preProduction,

  /// The production environment.
  production,
}
