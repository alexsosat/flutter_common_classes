import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_test/flutter_test.dart";

class _CountCubit extends Cubit<int> {
  _CountCubit() : super(0);
}

void main() {
  group("CubitExtension.safeEmit()", () {
    test("emits normally while the cubit is open", () {
      final cubit = _CountCubit();

      cubit.safeEmit(1);

      expect(cubit.state, 1);
      cubit.close();
    });

    test("does not throw and does not emit after the cubit is closed", () async {
      final cubit = _CountCubit();
      await cubit.close();

      expect(() => cubit.safeEmit(1), returnsNormally);
      expect(cubit.state, 0);
    });
  });
}
