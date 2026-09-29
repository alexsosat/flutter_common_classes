import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("HttpCallException", () {
    test("defaults type to HttpExceptions.other and data to null", () {
      final exception = HttpCallException(message: "message", title: "title");

      expect(exception.type, HttpExceptions.other);
      expect(exception.data, isNull);
    });

    test("stores explicit type and data", () {
      final exception = HttpCallException(
        message: "message",
        title: "title",
        type: HttpExceptions.badRequest,
        data: const {"a": 1},
      );

      expect(exception.type, HttpExceptions.badRequest);
      expect(exception.data, {"a": 1});
    });
  });
}
