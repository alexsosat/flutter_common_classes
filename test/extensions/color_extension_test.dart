import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ColorExtension.fromHex()", () {
    test("6-char hex without leading #", () {
      final color = ColorExtension.fromHex("112233");

      expect(color.toARGB32(), const Color(0xFF112233).toARGB32());
    });

    test("7-char hex with leading #", () {
      final color = ColorExtension.fromHex("#112233");

      expect(color.toARGB32(), const Color(0xFF112233).toARGB32());
    });

    test("8-char hex with alpha, no leading #", () {
      final color = ColorExtension.fromHex("80112233");

      expect(color.toARGB32(), const Color(0x80112233).toARGB32());
    });

    test("9-char hex with alpha and leading #", () {
      final color = ColorExtension.fromHex("#80112233");

      expect(color.toARGB32(), const Color(0x80112233).toARGB32());
    });
  });

  group("toHex()", () {
    const color = Color(0xFF112233);

    test("default: no hash sign, no alpha", () {
      expect(color.toHex(), "112233");
    });

    test("with hash sign, no alpha", () {
      expect(color.toHex(hashSign: true), "#112233");
    });

    test("no hash sign, with alpha", () {
      expect(color.toHex(withAlpha: true), "FF112233");
    });

    test("with hash sign and alpha", () {
      expect(color.toHex(hashSign: true, withAlpha: true), "#FF112233");
    });
  });

  group("darken()", () {
    const color = Color(0xFF808080);

    test("amount <= 0 returns the same color", () {
      expect(color.darken(0).toARGB32(), color.toARGB32());
      expect(color.darken(-5).toARGB32(), color.toARGB32());
    });

    test("amount > 100 returns pure black", () {
      expect(color.darken(101).toARGB32(), Colors.black.toARGB32());
    });

    test("normal amount reduces HSL lightness", () {
      final original = HSLColor.fromColor(color);
      final darkened = HSLColor.fromColor(color.darken(20));

      expect(darkened.lightness, lessThan(original.lightness));
    });
  });

  group("brighten()", () {
    const color = Color(0xFF808080);

    test("amount <= 0 returns the same color", () {
      expect(color.brighten(0).toARGB32(), color.toARGB32());
    });

    test("amount > 100 returns pure white", () {
      expect(color.brighten(101).toARGB32(), Colors.white.toARGB32());
    });

    test("normal amount increases channel values towards white", () {
      final brightened = color.brighten(20);

      expect((brightened.r * 255).round(), greaterThan((color.r * 255).round()));
    });
  });

  group("lighten()", () {
    const color = Color(0xFF808080);

    test("amount <= 0 returns the same color", () {
      expect(color.lighten(0).toARGB32(), color.toARGB32());
    });

    test("amount > 100 returns pure white", () {
      expect(color.lighten(101).toARGB32(), Colors.white.toARGB32());
    });

    test("normal amount increases HSL lightness", () {
      final original = HSLColor.fromColor(color);
      final lightened = HSLColor.fromColor(color.lighten(20));

      expect(lightened.lightness, greaterThan(original.lightness));
    });

    test("pure black lightens into a grey, not a saturated color", () {
      final lightened = Colors.black.lighten(20);
      final hsl = HSLColor.fromColor(lightened);

      expect(hsl.saturation, 0);
      expect(lightened.r, lightened.g);
      expect(lightened.g, lightened.b);
    });
  });
}
