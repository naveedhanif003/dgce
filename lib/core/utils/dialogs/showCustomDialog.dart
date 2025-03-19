import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  String? title,
  required String message,
  IconData? icon,
  String? positiveText,
  VoidCallback? onPositivePressed,
  String? negativeText,
  VoidCallback? onNegativePressed,
  bool dismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissible, // Can close by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: title != null
            ? Row(
          children: [
            if (icon != null) Icon(icon, color: AppColors.goldColor, size: 24),
            if (icon != null) SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
            : null,
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          if (negativeText != null)
            TextButton(
              onPressed: onNegativePressed ?? () => Navigator.pop(context),
              child: Text(negativeText),
            ),
          if (positiveText != null)
            TextButton(
              onPressed: onPositivePressed ?? () => Navigator.pop(context),
              child: Text(positiveText, style: TextStyle(color: AppColors.goldColor)),
            ),
        ],
      );
    },
  );
}
