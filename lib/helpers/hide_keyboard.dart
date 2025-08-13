import "package:flutter/material.dart";

/// Hides the keyboard
///
/// This function hides the keyboard when focused on a text field
void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
