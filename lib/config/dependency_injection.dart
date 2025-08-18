import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_flavor/flutter_flavor.dart";

import "environment_config.dart";
import "http_certificate_override.dart";

/// Class to inject the dependencies in the application
abstract class DependencyInjection {
  /// Initializes the dependency injection
  @mustCallSuper
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    HttpOverrides.global = HttpCertificateOverride();

    await injectCriticalServices();
  }

  /// Sets the fucntion to inject the critical services
  /// in the application
  ///
  /// This injects the services on the main thread
  ///
  /// WARNING: This method should not be called, this method is already
  /// called by the init method
  Future injectCriticalServices();

  /// Inject the services in the application
  ///
  /// This injects the services when the application is running
  /// These services are loaded during the splash screen
  Future injectServices();

  /// Inject the repositories in the application
  ///
  /// This injects the repositories when the application is running
  /// These repositories are loaded during the splash screen
  @mustCallSuper
  void injectPublicRepositories() {
    if (FlavorConfig.instance.name == Flavor.mock.name) {
      injectPublicMockRepositories();
    } else {
      injectPublicRemoteRepositories();
    }
  }

  /// Inject the repositories in the application
  ///
  /// This injects the repositories when the application is running
  /// These repositories are loaded during the splash screen
  @mustCallSuper
  void injectPrivateRepositories() {
    if (FlavorConfig.instance.name == Flavor.mock.name) {
      injectPrivateMockRepositories();
    } else {
      injectPrivateRemoteRepositories();
    }
  }

  /// Inject the repositories available only when the user is logged in
  void injectPrivateRemoteRepositories();

  /// Inject the mock repositories available only when the user is logged in
  ///
  /// This repositories are used for testing purposes and only be injected when
  /// the EnvironmentConfig is set to mock
  void injectPrivateMockRepositories();

  /// Inject the public remote repositories in the application
  void injectPublicRemoteRepositories();

  /// Inject the mock repositories available only when the user is logged in
  void injectPublicMockRepositories();
}
