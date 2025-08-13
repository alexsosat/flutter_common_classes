import 'package:confirm_alert/show_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_classes/flutter_common_classes.dart';

/// Shows a dialog with the error message
Future showFailureDialog({
  required BuildContext context,
  required Failure failure,
  ConfirmationDialogOptions options = const ConfirmationDialogOptions(
    type: DialogType.warning,
    showCancel: false,
    barrierDismissible: false,
  ),
}) =>
    showConfirmationDialog(
      context: context,
      texts: ConfirmationDialogTexts(
        title: failure.title,
        message: failure.message,
      ),
      options: options,
    );
