import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

enum SnackbarStatus { success, error, info }

void showSnackbar(
    {required BuildContext context,
    required SnackbarStatus status,
    required String message}) {
  switch (status) {
    case SnackbarStatus.success:
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
          maxLines: 3,
          backgroundColor: ColorsPalette.green,
          boxShadow: const [],
        ),
      );
      break;
    case SnackbarStatus.error:
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
          maxLines: 3,
          boxShadow: const [],
        ),
      );
      break;
    case SnackbarStatus.info:
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
          maxLines: 1,
          backgroundColor: Colors.purple,
          boxShadow: const [],
        ),
      );
      break;
  }
}


enum ToastStates { SUCCESS, ERROR, WARNING }

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0,
    );


Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}