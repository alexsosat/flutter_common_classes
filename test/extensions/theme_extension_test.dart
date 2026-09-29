import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ThemeExtension", () {
    testWidgets("exposes theme/textTheme/colorScheme and light-mode flags", (
      tester,
    ) async {
      final theme = ThemeData(brightness: Brightness.light);
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedContext.theme, Theme.of(capturedContext));
      expect(capturedContext.textTheme, Theme.of(capturedContext).textTheme);
      expect(
        capturedContext.colorScheme,
        Theme.of(capturedContext).colorScheme,
      );
      expect(capturedContext.theme.brightness, Brightness.light);
      expect(capturedContext.isLightMode, isTrue);
      expect(capturedContext.isDarkMode, isFalse);
    });

    testWidgets("reports dark-mode flags for a dark theme", (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedContext.isDarkMode, isTrue);
      expect(capturedContext.isLightMode, isFalse);
    });
  });
}
