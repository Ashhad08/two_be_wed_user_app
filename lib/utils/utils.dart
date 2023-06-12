import 'package:flutter/material.dart';

class Utils {
  static showSnackBar({
    required BuildContext context,
    required String message,
    int? maxLines,
    Color? color,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        margin: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Text(
          message,
          maxLines: maxLines,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
