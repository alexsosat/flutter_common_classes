import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

import "../helpers/fixtures.dart";

void main() {
  group("StateMixin factories", () {
    test("initial() has WidgetStatus.initial and no data/failure", () {
      final state = StateMixin<String>.initial();

      expect(state.status, WidgetStatus.initial);
      expect(state.data, isNull);
      expect(state.failure, isNull);
    });

    test("loading() has WidgetStatus.loading and no data/failure", () {
      final state = StateMixin<String>.loading();

      expect(state.status, WidgetStatus.loading);
      expect(state.data, isNull);
      expect(state.failure, isNull);
    });

    test("empty() has WidgetStatus.empty and no data/failure", () {
      final state = StateMixin<String>.empty();

      expect(state.status, WidgetStatus.empty);
      expect(state.data, isNull);
      expect(state.failure, isNull);
    });

    test("failure() carries the given failure with WidgetStatus.failure", () {
      final failure = sampleAppFailure();
      final state = StateMixin<String>.failure(failure);

      expect(state.status, WidgetStatus.failure);
      expect(state.failure, same(failure));
      expect(state.data, isNull);
    });

    group("success() empty-detection", () {
      test("empty List -> WidgetStatus.empty", () {
        final state = StateMixin<List<int>>.success(<int>[]);
        expect(state.status, WidgetStatus.empty);
      });

      test("non-empty List -> WidgetStatus.success", () {
        final state = StateMixin<List<int>>.success(<int>[1]);
        expect(state.status, WidgetStatus.success);
      });

      test("empty Set -> WidgetStatus.empty", () {
        final state = StateMixin<Set<int>>.success(<int>{});
        expect(state.status, WidgetStatus.empty);
      });

      test("non-empty Set -> WidgetStatus.success", () {
        final state = StateMixin<Set<int>>.success(<int>{1});
        expect(state.status, WidgetStatus.success);
      });

      test("empty Map -> WidgetStatus.empty", () {
        final state = StateMixin<Map<String, int>>.success(<String, int>{});
        expect(state.status, WidgetStatus.empty);
      });

      test("non-empty Map -> WidgetStatus.success", () {
        final state = StateMixin<Map<String, int>>.success(<String, int>{
          "a": 1,
        });
        expect(state.status, WidgetStatus.success);
      });

      test("empty String -> WidgetStatus.empty", () {
        final state = StateMixin<String>.success("");
        expect(state.status, WidgetStatus.empty);
      });

      test("non-empty String -> WidgetStatus.success", () {
        final state = StateMixin<String>.success("hello");
        expect(state.status, WidgetStatus.success);
      });

      test("empty Iterable (non-List/Set) -> WidgetStatus.empty", () {
        final state = StateMixin<Iterable<int>>.success(
          const Iterable<int>.empty(),
        );
        expect(state.status, WidgetStatus.empty);
      });

      test("non-empty Iterable (non-List/Set) -> WidgetStatus.success", () {
        final state = StateMixin<Iterable<int>>.success([1, 2].map((e) => e));
        expect(state.status, WidgetStatus.success);
      });

      test("non-collection data always -> WidgetStatus.success", () {
        expect(StateMixin<int>.success(0).status, WidgetStatus.success);
        expect(StateMixin<int>.success(42).status, WidgetStatus.success);
        expect(StateMixin<bool>.success(false).status, WidgetStatus.success);
      });

      test("success() carries the given data", () {
        final state = StateMixin<String>.success("payload");
        expect(state.data, "payload");
      });
    });
  });

  group("StateMixin equality", () {
    test("identical instances are equal", () {
      final state = StateMixin<String>.initial();
      expect(state == state, isTrue);
    });

    test("same status/data/failure are equal with matching hashCode", () {
      final failure = sampleAppFailure();
      final a = StateMixin<String>(
        status: WidgetStatus.failure,
        failure: failure,
      );
      final b = StateMixin<String>(
        status: WidgetStatus.failure,
        failure: failure,
      );

      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test("differing status are not equal", () {
      final a = StateMixin<String>(status: WidgetStatus.initial);
      final b = StateMixin<String>(status: WidgetStatus.loading);

      expect(a == b, isFalse);
    });

    test("differing data are not equal", () {
      final a = StateMixin<String>(status: WidgetStatus.success, data: "a");
      final b = StateMixin<String>(status: WidgetStatus.success, data: "b");

      expect(a == b, isFalse);
    });

    test("differing failure are not equal", () {
      final a = StateMixin<String>(
        status: WidgetStatus.failure,
        failure: sampleAppFailure(title: "A"),
      );
      final b = StateMixin<String>(
        status: WidgetStatus.failure,
        failure: sampleAppFailure(title: "B"),
      );

      expect(a == b, isFalse);
    });
  });
}
