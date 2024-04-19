import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/assets_manager.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/primary_button.dart';

import '../../../utils/colors_palette.dart';
import '../../loading_widget.dart';

class SimplePrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor, loadingWidgetColor;
  final Color? labelColor, iconColor;
  final bool isLoading;
  final BorderRadius? borderRadius;
  final String? icon;
  final double? fontSize;

  const SimplePrimaryButton({
    Key? key,
    this.loadingWidgetColor =  ColorsPalette.white,
    required this.label,
    this.onPressed,
    this.backgroundColor = ColorsPalette.primaryColor,
    this.labelColor = ColorsPalette.white,
    this.isLoading = false,
    this.borderRadius,
    this.icon,
    this.iconColor,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: isLoading ? () {} : onPressed,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      labelColor: labelColor,
      child: Center(
        child:  isLoading
            ? LoadingWidget(
          size: 20,
          color: loadingWidgetColor,
        )
            : icon != null ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon!, width: 20, height: 20, color: iconColor,),
            UtilValues.gap8,
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ) : Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
