import 'package:flutter/material.dart';


// ignore: non_constant_identifier_names
Widget AppSnackBar({
  required String text,
  required bool isSuccess,
  Duration? duration,
  SnackBarBehavior? behavior,
  int? maxLines,
  Color? textColor,
}) {
  return SnackBar(
    content: Text(
      text,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        color: textColor ?? Colors.white,
      ),
    ),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    duration: duration ?? const Duration(seconds: 2),
    behavior: behavior ?? SnackBarBehavior.floating,
  );
}
