import 'package:easy_localization/easy_localization.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/simple_primary_button.dart';
import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color iconColor;

  const MessageDialog({
    Key? key,
    required this.message,
    this.icon = Icons.info,
    this.iconColor = ColorsPalette.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      contentPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 100,
            color: iconColor,
          ),
          UtilValues.gap16,
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          UtilValues.gap24,
          SimplePrimaryButton(
            label: LocaleKeys.okay.tr(),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static Future<void> show(
      {required BuildContext context, required String message}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return MessageDialog(message: message);
      },
    );
  }
}
