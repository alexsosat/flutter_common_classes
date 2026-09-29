import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:mocktail/mocktail.dart";

/// Mock for [UseCaseAsync], the seam every loader cubit under test forwards
/// its `callUseCase()` to.
class MockUseCaseAsync<S, P> extends Mock implements UseCaseAsync<S, P> {}

/// Mock for [UseCase] (sync use cases).
class MockUseCase<S, P> extends Mock implements UseCase<S, P> {}

/// Registers fallback values mocktail needs for `any()`/`any(named: ...)`
/// matchers used against `params:` in `when`/`verify` calls.
void registerCommonFallbackValues() {
  registerFallbackValue(const NoParams());
}
