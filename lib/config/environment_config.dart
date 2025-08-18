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
      variables: getVariables(flavor),
    );
  }

  static Map<String, dynamic> getVariables(Flavor flavor) => switch (flavor) {
    Flavor.mock => mockVariables,
    Flavor.local => localVariables,
    Flavor.test => testVariables,
    Flavor.production => prodVariables,
    Flavor.preProduction => preProdVariables,
  };

  static const Map<String, dynamic> mockVariables = {};

  static const Map<String, dynamic> localVariables = {};

  static const Map<String, dynamic> testVariables = {};

  static const Map<String, dynamic> preProdVariables = {};

  static const Map<String, dynamic> prodVariables = {};
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
