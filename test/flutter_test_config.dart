import "dart:async";

import "package:confirm_alert/localization/l10n.dart";
import "package:flutter/widgets.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_test/flutter_test.dart";
import "package:intl/date_symbol_data_local.dart";

/// Global bootstrap that `flutter test` runs once per test file, before that
/// file's `main()`. Both localization singletons back plain static getters
/// (`FlutterCommonLocalizations.current`, used by `AppFailure`/exception
/// factories; `ConfirmAlertLocalizations.current`, used by
/// `showFailureDialog`), so they must be loaded once, process-wide, before
/// any test touches them.
///
/// `FlutterCommonLocalizations.load` also sets `Intl.defaultLocale` to
/// `"es"`, which makes any implicit-locale `DateFormat` (e.g.
/// `DateExtension.toStringFormat`, `StringExtension.toDate`) require `"es"`
/// date symbol data to be initialized too, or they throw
/// `LocaleDataException` — hence `initializeDateFormatting("es")` below.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await FlutterCommonLocalizations.load(const Locale("es"));
  await ConfirmAlertLocalizations.load(const Locale("es"));
  await initializeDateFormatting("es");
  await testMain();
}
