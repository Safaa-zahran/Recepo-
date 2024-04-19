import 'package:flutter/material.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/simple_primary_button.dart';

import '../utils/colors_palette.dart';
import '../utils/util_values.dart';

class MessageWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? actionButtonLabel;
  final VoidCallback? onActionButtonTapped;
  final Color iconColor;

  const MessageWidget({
    Key? key,
    required this.icon,
    required this.message,
    this.actionButtonLabel,
    this.onActionButtonTapped,
    this.iconColor = ColorsPalette.primaryColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UtilValues.padding24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 150,
            color: iconColor,
          ),
          UtilValues.gap16,
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorsPalette.black,
              fontSize: 20,
            ),
          ),
          if (![actionButtonLabel, onActionButtonTapped].contains(null)) ...[
            UtilValues.gap32,
            Padding(
              padding: UtilValues.padding16,
              child: SimplePrimaryButton(
                label: actionButtonLabel!,
                onPressed: onActionButtonTapped,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
