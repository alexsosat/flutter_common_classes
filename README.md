<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

### Environment / flavor configuration

`EnvironmentConfig` doesn't ship a fixed set of flavors. Instead, each app
declares its own flavor enum implementing `AppFlavor`, using Dart's enhanced
enums to attach a `variables` map per value:

```dart
enum Flavor implements AppFlavor {
  mock(variables: {}),
  test(variables: {'apiUrl': 'https://test.api'}),
  production(variables: {'apiUrl': 'https://api'});

  const Flavor({required this.variables});

  @override
  final Map<String, dynamic> variables;
}
```

An app can declare as many or as few flavors as it needs, with any names,
without changing this package.

Initialize it in `main()`:

```dart
void main() {
  EnvironmentConfig.init(flavor: Flavor.mock);
  runApp(const MyApp());
}
```

`DependencyInjection.injectPublicRepositories()` /
`injectPrivateRepositories()` automatically route to mock vs. remote
repositories based on the current flavor's name matching `"mock"` — no
manual wiring needed. If your app names its mock or production flavors
something else, pass `mockFlavorName` / `productionFlavorName` to `init`:

```dart
EnvironmentConfig.init(
  flavor: Flavor.demo,
  mockFlavorName: 'demo',
);
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
