import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("toStringFormat()", () {
    test("uses yyyy-MM-dd by default, zero-padding month/day", () {
      expect(DateTime(2024, 1, 5).toStringFormat(), "2024-01-05");
    });

    test("honors a custom format string", () {
      expect(
        DateTime(2024, 1, 5).toStringFormat(format: "dd/MM/yyyy"),
        "05/01/2024",
      );
    });
  });
}
