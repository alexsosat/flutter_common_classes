---
name: fod-state-management
description: >-
  Guide for implementing Cubit state management using StateMixin, LoaderCubit, AutoLoaderCubit, ValueLoaderCubit, and safeEmit extension.
  Use when building feature Cubits for single-fetch, automatic, or parameterized data streams with flutter_common_classes.
---

# State Management Guidelines (`flutter_common_classes`)

This skill explains how to build robust, reactive state management components using `flutter_common_classes`.

---

## 1. `StateMixin<T>` & `WidgetStatus`

`StateMixin<T>` standardizes UI states into five explicit statuses (`WidgetStatus`):

| `WidgetStatus` | Description |
| :--- | :--- |
| `initial` | Initial default state before data fetching begins. |
| `loading` | Active data fetch or background processing in progress. |
| `success` | Data successfully loaded and is non-empty. |
| `empty` | Data operation completed, but result contains empty collection (`List`, `Map`, `Set`, `String`). |
| `failure` | Operation failed; contains a `Failure` object with error message and title. |

### Factory Constructors
- `StateMixin.initial()`
- `StateMixin.loading()`
- `StateMixin.success(data)` *(Automatically sets status to `WidgetStatus.empty` if data is an empty Iterable/Map/String)*
- `StateMixin.empty()`
- `StateMixin.failure(failure)`

---

## 2. Recommended Cubit Base Classes

> [!NOTE]
> `AutoLoaderCubit` replace deprecated `GetInfoCubit`.
> `ValueLoaderCubit` replace deprecated `GetInfoByValueCubit`.

### A. Automatic Fetching: `AutoLoaderCubit<T>`

Use `AutoLoaderCubit<T>` when data should be fetched immediately upon Cubit instantiation (e.g. page load).

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

class AccountListCubit extends AutoLoaderCubit<List<AccountEntity>> {
  @override
  Future<Either<Failure, List<AccountEntity>>> callUseCase() {
    final getAccountsUseCase = GetIt.I.get<GetAccountsUseCase>();
    return getAccountsUseCase.call(params: const NoParams());
  }
}
```

### B. Parameterized Fetching: `ValueLoaderCubit<T, J>`

Use `ValueLoaderCubit<T, J>` when data retrieval depends on a parameter or identifier `J` (e.g., loading items for a selected category ID).

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

class CategoryDetailCubit extends ValueLoaderCubit<CategoryEntity, String> {
  @override
  Future<Either<Failure, CategoryEntity>> callUseCase() {
    final getCategoryById = GetIt.I.get<GetCategoryByIdUseCase>();
    return getCategoryById.call(params: GetCategoryByIdParams(categoryId: value!));
  }
}
```

**Usage in UI / Controller**:
```dart
// Set category ID and automatically trigger getInfo()
context.read<CategoryDetailCubit>().setValueAndRefresh("category_123");
```

### C. Custom / Manual Fetching: `LoaderCubit<T>`

Use `LoaderCubit<T>` directly when you need manual control over initial state or loading triggers:

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:fpdart/fpdart.dart';

class ProfileCubit extends LoaderCubit<UserProfile> {
  ProfileCubit() : super(StateMixin.initial());

  @override
  Future<Either<Failure, UserProfile>> callUseCase() {
    // Implement use case call
  }
}
```

---

## 3. Safe State Emissions with `safeEmit`

`flutter_common_classes` provides a `safeEmit` extension method on `Cubit` to prevent `StateError` crashes when emitting state after a Cubit is closed:

```dart
void performAction() async {
  safeEmit(StateMixin.loading());

  final result = await useCase.call(params: params);

  result.fold(
    (failure) => safeEmit(StateMixin.failure(failure)),
    (data) => safeEmit(StateMixin.success(data)),
  );
}
```
