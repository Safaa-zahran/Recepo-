import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/widgets/form_widgets/secondary_button/secondary_button.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';

class SimpleSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final bool isLoading;
  final BorderRadius? borderRadius;

  const SimpleSecondaryButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.color = ColorsPalette.primaryColor,
    this.isLoading = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      onPressed: isLoading ? () {} : onPressed,
      color: color,
      borderRadius: borderRadius,
      child: isLoading
          ? const LoadingWidget(
              size: 20,
              color: ColorsPalette.white,
            )
          : Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
