import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool isLoading;
  final BorderRadius? borderRadius;

  const PrimaryButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.backgroundColor = ColorsPalette.primaryColor,
    this.labelColor = ColorsPalette.white,
    this.isLoading = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(47),
        backgroundColor: backgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? UtilValues.borderRadius10),
      ),
      child: child,
    );
  }
}
