---
name: fod-ui-views-and-widgets
description: >-
  Guide for building responsive Flutter screens and UI widgets using PageLoaderWidget, CubitWidgetStateBuilder, CubitSkeletonizerStateBuilder, FormBuilderSearchableBottomSheet, FailureView, and package extensions.
  Use when implementing Flutter UI components, form inputs, loading screens, and error views with flutter_common_classes.
---

# UI Views & Widgets Guidelines (`flutter_common_classes`)

This skill explains how to build responsive, declarative user interfaces using `flutter_common_classes` views and widgets.

---

## 1. Full-Page Loading Architecture: `PageLoaderWidget`

`PageLoaderWidget<T extends LoaderCubit<B>, B>` provides a standardized structure for entire screens that load async data. It handles pull-to-refresh, loading states, empty states, error states, and dependency injection via `BlocProvider`.

### Example Implementation

```dart
import 'package:flutter/material.dart';
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:get_it/get_it.dart';

class CategoryListPage extends PageLoaderWidget<CategoryListCubit, List<CategoryEntity>> {
  const CategoryListPage({super.key});

  @override
  CategoryListCubit get mainCubit => GetIt.I.get<CategoryListCubit>();

  // Optional: Use Skeletonizer loading effect instead of default spinner
  @override
  LoadingStyle get loadingStyle => SkeletonizerLoadingStyle(
    mockData: [
      CategoryEntity(id: "1", name: "Mock Category 1"),
      CategoryEntity(id: "2", name: "Mock Category 2"),
    ],
  );

  // Optional: Provide custom Scaffold structure (AppBar, FloatingActionButton)
  @override
  Widget? pageScaffold(BuildContext context, Widget child) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categorías")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Add Category"),
        child: const Icon(Icons.add),
      ),
      body: child, // child contains the reactive view loader
    );
  }

  // Required: Render the UI when state is WidgetStatus.success
  @override
  Widget view(BuildContext context, List<CategoryEntity> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final category = data[index];
        return ListTile(
          title: Text(category.name),
          onTap: () => print("Selected ${category.name}"),
        );
      },
    );
  }
}
```

---

## 2. In-Widget State Builders

### A. `CubitWidgetStateBuilder<T, B>`
Use `CubitWidgetStateBuilder` inside custom widget subtrees to render different states of a `Cubit` emitting `StateMixin<B>`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_common_classes/flutter_common_classes.dart';

class AccountSummaryWidget extends StatelessWidget {
  const AccountSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CubitWidgetStateBuilder<AccountSummaryCubit, AccountSummaryEntity>(
      onLoading: const Center(child: CircularProgressIndicator.adaptive()),
      onSuccess: (data) => Text("Balance: \$${data.totalBalance}"),
      onEmpty: const Text("No hay datos disponibles"),
      onFailure: (failure) => Text(failure.message),
    );
  }
}
```

### B. `CubitSkeletonizerStateBuilder<T, B>`
Use `CubitSkeletonizerStateBuilder` when you want a skeleton/shimmer loader for a widget block:

```dart
CubitSkeletonizerStateBuilder<UserCubit, UserEntity>(
  onLoading: SkeletonizerLoader(
    mock: UserEntity.mock(),
    widget: (mockData) => UserCardWidget(user: mockData),
  ),
  onSuccess: (user) => UserCardWidget(user: user),
);
```

---

## 3. Searchable Bottom Sheet Form Field

`FormBuilderSearchableBottomSheet<T>` integrates `flutter_form_builder` with async search bottom sheets driven by a use case returning `Either<Failure, List<T>>`.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_common_classes/flutter_common_classes.dart';

class CategorySelectField extends StatelessWidget {
  final Future<Either<Failure, List<CategoryEntity>>> Function() getCategoriesUseCase;

  const CategorySelectField({super.key, required this.getCategoriesUseCase});

  @override
  Widget build(BuildContext context) {
    return FormBuilderSearchableBottomSheet<CategoryEntity>(
      name: "categoryId",
      label: "Seleccionar Categoría",
      useCase: getCategoriesUseCase,
      itemAsString: (category) => category.name,
      compareFn: (item1, item2) => item1.id == item2.id,
      showSearchBox: true,
      clearButtonVisible: true,
      onChanged: (selectedCategory) {
        if (selectedCategory != null) {
          print("Selected category: ${selectedCategory.name}");
        }
      },
    );
  }
}
```

---

## 4. Error Display: `FailureView` & `FailureDialog`

### `FailureView`
Displays error titles, messages, and animated Lottie graphics based on HTTP exception type (`no_internet.json`, `server_error.json`, `unauthorized.json`, `bad_request.json`):

```dart
FailureView(failure);
```

### `FailureDialog`
Quick alert dialog for failures:
```dart
showFailureDialog(context: context, failure: failure);
```

---

## 5. Built-in Extensions & Utilities

- **Theme Extensions**:
  ```dart
  context.colorScheme.primary
  context.textTheme.titleMedium
  ```
- **Keyboard Utility**:
  ```dart
  hideKeyboard(context);
  ```
- **String Extensions**:
  ```dart
  "hello world".capitalize() // "Hello world"
  "test@example.com".isEmail // true
  ```
