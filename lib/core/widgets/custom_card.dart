import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final BorderRadius? borderRadius;
  final double? height;
  final VoidCallback? onTap;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding = UtilValues.padding16,
    this.color = ColorsPalette.lightGrey,
    this.borderRadius,
    this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? UtilValues.borderRadius10,
        ),
        child: child,
      ),
    );
  }
}
