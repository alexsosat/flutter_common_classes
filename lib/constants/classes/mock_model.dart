export "package:faker/faker.dart" hide Color;

/// Base class for all mocking classes
abstract class MockModel<T> {
  /// Base class for all mocking classes
  MockModel();

  /// Returns an object with mock data
  T mockData() {
    throw UnimplementedError();
  }
}
