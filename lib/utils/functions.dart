import 'package:flutter/material.dart';

void handleActionResult({
  required BuildContext context,
  String? errorMessage,
  required String successMessage,
  VoidCallback? onSuccessNavigation,
}) {
  if (errorMessage == null) {
    if (onSuccessNavigation != null) {
      onSuccessNavigation();
    }
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(errorMessage ?? successMessage),
    behavior: SnackBarBehavior.fixed,
  ));
}
