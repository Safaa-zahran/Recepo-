import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/util_values.dart';

import '../../../utils/colors_palette.dart';

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color color;
  final bool isLoading;
  final BorderRadius? borderRadius;

  const SecondaryButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.color = ColorsPalette.primaryColor,
    this.isLoading = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(47),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? UtilValues.borderRadius10,
          side: BorderSide(color: color),
        ),
      ),
      child: child,
    );
  }
}
