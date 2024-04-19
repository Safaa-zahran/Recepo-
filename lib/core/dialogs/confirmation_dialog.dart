import 'package:easy_localization/easy_localization.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/simple_primary_button.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title;
  final String? message;

  const ConfirmationDialog({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      contentPadding: UtilValues.padding16,
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UtilValues.gap8,
          Text(
            title ?? LocaleKeys.areYouSure.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (message != null) ...[
            UtilValues.gap16,
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(height: 1.3),
            ),
          ],
          UtilValues.gap24,
          Row(
            children: [
              Expanded(
                child: SimplePrimaryButton(
                  label: LocaleKeys.no.tr(),
                  backgroundColor: ColorsPalette.grey,
                  labelColor: ColorsPalette.black,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
              UtilValues.gap16,
              Expanded(
                child: SimplePrimaryButton(
                  label: LocaleKeys.yes.tr(),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<bool> show({
    required BuildContext context,
    String? title,
    String? message,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      //barrierDismissible: false,
      builder: (context) {
        return ConfirmationDialog(
          title: title,
          message: message,
        );
      },
    );

    return confirmed ?? false;
  }
}


class ConfirmationAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;

  const ConfirmationAlertDialog({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      contentPadding: UtilValues.padding16,
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UtilValues.gap8,
          Text(
            title ?? LocaleKeys.areYouSure.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (message != null) ...[
            UtilValues.gap16,
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(height: 1.3),
            ),
          ],
          UtilValues.gap24,
          SimplePrimaryButton(
            label: LocaleKeys.ok.tr(),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  static Future<bool> show({
    required BuildContext context,
    String? title,
    String? message,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      //barrierDismissible: false,
      builder: (context) {
        return ConfirmationDialog(
          title: title,
          message: message,
        );
      },
    );

    return confirmed ?? false;
  }
}
