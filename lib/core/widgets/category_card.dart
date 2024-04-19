
import 'package:posts_app/core/utils/font.dart';
import 'package:flutter/material.dart';

import '../utils/colors_palette.dart';
import '../utils/util_values.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        padding: UtilValues.padding4,
        decoration: BoxDecoration(
          /*boxShadow: [
            BoxShadow(color: ColorsPalette.darkGrey, offset: Offset(10, 90), blurRadius: 15)
          ],*/
          //color: selected ? ColorsPalette.primaryColor : ColorsPalette.white,
          borderRadius: UtilValues.borderRadius25,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: NSTextStyles.font,
              fontWeight: selected ? FontWeight.bold : FontWeight.w400,
              fontSize: 14,
              height: 2,
              letterSpacing: 1.5,
              decorationColor: ColorsPalette.primaryColor,
                color: Colors.transparent,
                shadows: [Shadow(color: selected ? ColorsPalette.primaryColor : ColorsPalette.lightGrey.withOpacity(0.3), offset: Offset(0, -10))],
                decoration: selected ? TextDecoration.underline : TextDecoration.none,
                decorationThickness: 3
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
