import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';

class TernaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool dense;
  final EdgeInsets? padding;

  const TernaryButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.color = ColorsPalette.primaryColor,
    this.dense = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: padding,
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        elevation: 0,
        foregroundColor: color,
        visualDensity: dense ? VisualDensity.compact : null,
        tapTargetSize: dense ? MaterialTapTargetSize.shrinkWrap : null,
        shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      ),
      child: Text(label),
    );
  }
}
