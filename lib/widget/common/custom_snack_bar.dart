import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/constants.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String successMessage,
    String? errorMessage,
  }) : super(
          content: Text(
            errorMessage ?? successMessage,
            style: const TextStyle(color: Colors.black87),
          ),
          backgroundColor: errorMessage != null
              ? Color(dangerRed)
              : Color(detailLightPurple),
        );
}
