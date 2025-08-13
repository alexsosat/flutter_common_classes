/// Base class for all params classes
abstract class Params {
  /// Base class for all params classes
  const Params();

  /// The headers to send to the API
  Map<String, dynamic> headers() => {};

  /// The queries to send to the API
  Map<String, dynamic>? queries() => null;

  /// The body to send to the API
  Map<String, dynamic> body() => {};
}

/// Class to represent the no params
class NoParams extends Params {
  /// No params
  const NoParams();
}
