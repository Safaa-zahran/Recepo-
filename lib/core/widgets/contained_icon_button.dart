import 'package:flutter/material.dart';

import '../utils/colors_palette.dart';
import '../utils/util_values.dart';

class ContainedIconButton extends StatelessWidget {
  final icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final double? height;

  const ContainedIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = ColorsPalette.white, this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        height: height,
        margin: UtilValues.padding8,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(borderRadius: UtilValues.borderRadius10, color: backgroundColor,
           /* boxShadow: const [
              BoxShadow(color: ColorsPalette.darkGrey, offset: Offset(3, 3), blurRadius: 3)
            ]*/
        ),
        child: SizedBox(
            width: 40,
            height: 40,
            child: icon
        ),
      ),
    );
  }
}
