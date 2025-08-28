import "dart:async";

import "package:dropdown_search/dropdown_search.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:form_builder_dropdown_search/form_builder_dropdown_search.dart";
import "package:fpdart/fpdart.dart";

import "../errors/failure.dart";
import "../views/failure_view.dart";

/// A form field that shows a bottom sheet when clicked
class FormBuilderSearchableBottomSheet<T> extends StatelessWidget {
  /// A form field that shows a bottom sheet when focused
  const FormBuilderSearchableBottomSheet({
    required this.name,
    required this.useCase,
    required this.itemBuilder,
    required this.label,
    required this.compareFn,
    required this.itemAsString,
    this.title,
    this.onChanged,
    this.emptyText,
    this.validator,
    this.disabledItemFn,
    this.bottomSheetKey,
    this.filterFn,
    this.errorText,
    this.helperText,
    this.clearButtonVisible = true,
    this.showSearchBox = true,
    this.enabled = true,
    super.key,
  });

  /// Name of the field
  final String name;

  /// Title of the bottom sheet
  final Widget? title;

  /// Function to get the items to be displayed in the bottom sheet
  final Future<Either<Failure, List<T>>> Function() useCase;

  /// True if the search box should be visible
  final bool showSearchBox;

  /// Validator to be applied to the form field
  final String? Function(T?)? validator;

  /// Label to be displayed when no value selected
  final String? label;

  /// Text to be displayed when the items are empty
  final String? emptyText;

  /// True if the clear button should be visible
  final bool clearButtonVisible;

  /// Builder to display the options in the bottom sheet
  final DropdownSearchPopupItemBuilder<T>? itemBuilder;

  /// Defines if an item of the popup is enabled or not, if the item is disabled,
  /// it cannot be clicked
  final DropdownSearchPopupItemEnabled<T>? disabledItemFn;

  /// Function to be called when the value changes
  final ValueChanged<T?>? onChanged;

  /// Function that compares two object with the same type to detected
  /// if it's the selected item or not
  final DropdownSearchCompareFn<T> compareFn;

  /// Customize the fields the be shown
  final DropdownSearchItemAsString<T> itemAsString;

  /// Key to be used for the bottom sheet
  final GlobalKey<FormBuilderDropdownSearchState<T>>? bottomSheetKey;

  ///	Custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  /// True if the field is enabled
  final bool enabled;

  /// Message to be displayed for programmatic errors
  final String? errorText;

  /// Message that helps the user to understand the field
  final String? helperText;

  @override
  Widget build(BuildContext context) => FormBuilderDropdownSearch<T>(
    key: bottomSheetKey,
    name: name,
    enabled: enabled,
    items: _getItems,
    clearButtonProps: ClearButtonProps(
      isVisible: clearButtonVisible,
      icon: const Icon(Icons.clear),
    ),
    validator: validator,
    popupProps: PopupProps.modalBottomSheet(
      title: title != null
          ? Padding(padding: const EdgeInsets.all(20), child: title!)
          : null,
      onItemsLoaded: (value) {
        // TODO: Implement onItemsLoaded
      },
      emptyBuilder: _emptyBuilder,
      itemBuilder: itemBuilder,
      loadingBuilder: (context, searchEntry) =>
          const Center(child: CircularProgressIndicator.adaptive()),
      errorBuilder: _errorBuilder,
      disabledItemFn: disabledItemFn,
      cacheItems: true,
      showSearchBox: showSearchBox,
      searchDelay: Duration.zero,
      showSelectedItems: true,
      modalBottomSheetProps: const ModalBottomSheetProps(
        useRootNavigator: true,
      ),
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          labelText: FlutterCommonLocalizations.current.search,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    ),
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      errorText: errorText,
      helperText: helperText,
      helperMaxLines: 2,
    ),
    compareFn: compareFn,
    itemAsString: itemAsString,
    filterFn: filterFn,
  );

  FutureOr<List<T>> _getItems(String _, LoadProps? __) async {
    final itemsResponse = await useCase();

    return itemsResponse.fold(
      // ignore: only_throw_errors
      (failure) => throw failure,
      (items) => items,
    );
  }

  Widget _emptyBuilder(_, __) =>
      Center(child: Text(emptyText ?? "No se encontraron elementos"));

  Widget _errorBuilder(_, __, exception) {
    if (exception is Failure) {
      return Center(child: FailureView(exception));
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Ocurrió un error en la aplicación"),
          Text(exception.toString()),
        ],
      ),
    );
  }
}
