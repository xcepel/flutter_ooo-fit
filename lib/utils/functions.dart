import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/custom_snack_bar.dart';

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
  ScaffoldMessenger.of(context).showSnackBar(
    CustomSnackBar(
      successMessage: successMessage,
      errorMessage: errorMessage,
    ),
  );
}
