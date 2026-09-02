---
name: fod-architecture-setup
description: >-
  Guide for setting up Flutter application entry point, dependency injection using DependencyInjection class,
  environment configuration with EnvironmentConfig & Flavor, and core services (NetworkInfo, SecureStorageService, LoggerService).
  Use when initializing a new Flutter project or configuring application lifecycle, DI, and environments with flutter_common_classes.
---

# Architecture Setup & Application Initialization (`flutter_common_classes`)

This skill describes how to initialize a Flutter application using the `flutter_common_classes` package, configure environments/flavors, set up dependency injection, and integrate core infrastructure services.

---

## 1. Environment & Flavor Configuration

`flutter_common_classes` uses `EnvironmentConfig` and an `AppFlavor` interface to manage configuration variables per build target. The package does **not** ship a fixed flavor set — each app declares its own flavor enum implementing `AppFlavor`, with whatever values it needs (e.g. `mock`, `test`, `production`, or a larger set like `mock`, `local`, `test`, `preProduction`, `sandbox`, `production`).

### Step 1: Define Environment Configurations
Declare an app-specific `Flavor` enum implementing `AppFlavor` using Dart enhanced enums, then initialize `EnvironmentConfig` with it:

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';

enum Flavor implements AppFlavor {
  mock(variables: {}),
  test(variables: {'apiUrl': 'https://test.api'}),
  production(variables: {'apiUrl': 'https://api'});

  const Flavor({required this.variables});

  @override
  final Map<String, dynamic> variables;
}

void setupEnvironment(Flavor flavor) {
  EnvironmentConfig.init(flavor: flavor);
}
```

`DependencyInjection.injectPublicRepositories()` / `injectPrivateRepositories()` route to mock vs. remote repositories based on the current flavor's name matching `"mock"`. If your app names its mock or production flavor something else, pass `mockFlavorName` / `productionFlavorName` to `init`.

---

## 2. Dependency Injection Setup

Implement an app-level Dependency Injection class by extending `DependencyInjection` from `flutter_common_classes`.

### Step 2: Subclass `DependencyInjection`

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class AppDependencyInjection extends DependencyInjection {
  @override
  Future<void> injectCriticalServices() async {
    // Services required before app starts (e.g. storage, logger, network info)
    sl.registerLazySingleton<LoggerService>(() => LoggerService());
    sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  }

  @override
  Future<void> injectServices() async {
    // Additional services loaded during splash or app startup
  }

  @override
  void injectPublicRemoteRepositories() {
    // Register public API repositories (e.g., auth, public content)
    // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(...));
  }

  @override
  void injectPublicMockRepositories() {
    // Register public mock repositories for offline/test mode
    // sl.registerLazySingleton<AuthRepository>(() => MockAuthRepository(...));
  }

  @override
  void injectPrivateRemoteRepositories() {
    // Register authenticated API repositories (called after login)
    // sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(...));
  }

  @override
  void injectPrivateMockRepositories() {
    // Register authenticated mock repositories
    // sl.registerLazySingleton<ProfileRepository>(() => MockProfileRepository(...));
  }
}
```

---

## 3. Core Services Usage

### LoggerService
Centralized logging wrapper:
```dart
final logger = sl<LoggerService>();
logger.i("Application initialized successfully");
logger.e("Failed to connect", error: exception, stackTrace: stackTrace);
```

### SecureStorageService
Encrypted key-value storage wrapper using `flutter_secure_storage`:
```dart
final storage = sl<SecureStorageService>();

// Write data
await storage.write(key: LocalDataSourceKeys.token, value: "auth_token_string");

// Read data
final token = await storage.read(key: LocalDataSourceKeys.token);

// Delete data
await storage.delete(key: LocalDataSourceKeys.token);
```

### NetworkInfo
Check active internet connection status using `internet_connection_checker_plus`:
```dart
final networkInfo = sl<NetworkInfo>();

if (await networkInfo.isConnected) {
  // Execute remote network request
} else {
  // Fallback to local cache or throw connection error
}
```

---

## 4. Main Entry Point (`main.dart`)

Putting environment config, SSL override, and dependency injection together in `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'core/di/app_dependency_injection.dart';

void main() async {
  // 1. Initialize environment (e.g., production, test, or local)
  EnvironmentConfig.init(flavor: Flavor.production); // Flavor is your app's own enum implementing AppFlavor

  // 2. Initialize dependency injection & critical services
  final di = AppDependencyInjection();
  await di.init();

  // 3. Register public repositories based on flavor
  di.injectPublicRepositories();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(useMaterial3: true),
      home: const SplashPage(),
    );
  }
}
```
