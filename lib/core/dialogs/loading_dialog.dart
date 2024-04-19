import 'package:easy_localization/easy_localization.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      contentPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LoadingWidget(),
          UtilValues.gap24,
          Text(
            LocaleKeys.loading.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> show({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const LoadingDialog();
      },
    );
  }
}
