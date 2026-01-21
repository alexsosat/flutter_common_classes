import "dart:async";

import "package:dropdown_search/dropdown_search.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:form_builder_dropdown_search/form_builder_dropdown_search.dart";
import "package:fpdart/fpdart.dart" show Either;

import "../errors/failure.dart";
import "../views/failure_view.dart";

/// A form field that shows a bottom sheet when clicked
class FormBuilderSearchableBottomSheet<T> extends StatefulWidget {
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
    this.autoSelectUniqueItem = false,
    this.suggestedItemsUseCase,
    this.suggestedItemBuilder,
    super.key,
  });

  /// Name of the field
  final String name;

  /// Title of the bottom sheet
  final Widget? title;

  /// Function to get the items to be displayed in the bottom sheet
  final Future<Either<Failure, List<T>>> Function() useCase;

  /// Function to get the suggested items to be displayed in the bottom sheet
  final Either<Failure, List<T>> Function()? suggestedItemsUseCase;

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

  /// Builder to display the suggested items in the bottom sheet
  final FavoriteItemsBuilder<T>? suggestedItemBuilder;

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

  /// True if the first item should be automatically selected
  ///
  /// The auto select first item is only enabled if the field has only one item.
  final bool autoSelectUniqueItem;

  /// Message to be displayed for programmatic errors
  final String? errorText;

  /// Message that helps the user to understand the field
  final String? helperText;

  @override
  State<FormBuilderSearchableBottomSheet<T>> createState() =>
      _FormBuilderSearchableBottomSheetState<T>();
}

class _FormBuilderSearchableBottomSheetState<T>
    extends State<FormBuilderSearchableBottomSheet<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.autoSelectUniqueItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _automaticSelectFirstItem();
      });
    }
  }

  @override
  Widget build(BuildContext context) => FormBuilderDropdownSearch<T>(
    key: widget.bottomSheetKey,
    name: widget.name,
    enabled: widget.enabled,
    items: _getItems,
    clearButtonProps: ClearButtonProps(
      isVisible: widget.clearButtonVisible,
      icon: const Icon(Icons.clear),
    ),
    validator: widget.validator,
    popupProps: PopupProps.modalBottomSheet(
      title: widget.title != null
          ? Padding(padding: const EdgeInsets.all(20), child: widget.title!)
          : null,
      suggestedItemProps: SuggestedItemProps(
        showSuggestedItems: widget.suggestedItemsUseCase != null,
        suggestedItems: widget.suggestedItemsUseCase != null
            ? (items) => _getSuggestedItems(items)
            : null,
        suggestedItemBuilder: widget.suggestedItemBuilder,
      ),
      emptyBuilder: _emptyBuilder,
      itemBuilder: widget.itemBuilder,
      loadingBuilder: (context, searchEntry) =>
          const Center(child: CircularProgressIndicator.adaptive()),
      errorBuilder: _errorBuilder,
      disabledItemFn: widget.disabledItemFn,
      cacheItems: true,
      showSearchBox: widget.showSearchBox,
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
    onChanged: widget.onChanged,
    decoration: InputDecoration(
      labelText: widget.label,
      errorText: widget.errorText,
      helperText: widget.helperText,
      helperMaxLines: 2,
    ),
    compareFn: widget.compareFn,
    itemAsString: widget.itemAsString,
    filterFn: widget.filterFn,
  );

  FutureOr<List<T>> _getItems(String _, LoadProps? __) async {
    final itemsResponse = await widget.useCase();

    return itemsResponse.fold(
      // ignore: only_throw_errors
      (failure) => throw failure,
      (items) => items,
    );
  }

  Widget _emptyBuilder(_, __) =>
      Center(child: Text(widget.emptyText ?? "No se encontraron elementos"));

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

  /// Get the suggested items to be displayed in the bottom sheet
  List<T> _getSuggestedItems(List<T> items) {
    final suggestedItemsResponse = widget.suggestedItemsUseCase!();

    List<T> suggestedItems = [];

    suggestedItemsResponse.fold(
      // ignore: only_throw_errors
      (failure) => throw failure,
      (value) => suggestedItems = value,
    );

    suggestedItems = suggestedItems
        .where((item) => items.contains(item))
        .toList();

    return suggestedItems;
  }

  Future<void> _automaticSelectFirstItem() async {
    final itemsResponse = await widget.useCase();

    List<T> items = [];

    itemsResponse.fold((failure) => {}, (value) => items = value);

    if (items.isEmpty || items.length > 1) return;

    widget.bottomSheetKey?.currentState?.updateValue(items.first);
  }
}
