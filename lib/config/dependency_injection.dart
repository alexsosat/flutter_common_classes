import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_flavor/flutter_flavor.dart";

import "environment_config.dart";
import "http_certificate_override.dart";

/// Class to inject the dependencies in the application
abstract class DependencyInjection {
  /// Initializes the dependency injection
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    HttpOverrides.global = HttpCertificateOverride();

    await _injectCriticalServices();
  }

  /// Inject the critical services in the application
  ///
  /// This injects the services on the main thread
  /// WARNING: This method should be called before the application starts
  /// keep it simple so it doesn't take too long to execute
  Future _injectCriticalServices();

  /// Inject the services in the application
  ///
  /// This injects the services when the application is running
  /// These services are loaded during the splash screen
  Future injectServices();

  /// Inject the repositories in the application
  ///
  /// This injects the repositories when the application is running
  /// These repositories are loaded during the splash screen
  // ignore: long-method
  void injectPublicRepositories() {
    if (FlavorConfig.instance.name == Flavor.mock.name) {
      _injectMockRepositories();
    } else {
      _injectRealRepositories();
    }
  }

  /// Inject the repositories available only when the user is logged in
  void injectPrivateRepositories() {}

  void _injectMockRepositories() {}

  void _injectRealRepositories() {}
}
