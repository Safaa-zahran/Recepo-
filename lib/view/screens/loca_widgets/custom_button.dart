
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/colors_palette.dart';


class CustomSideBarButton extends StatelessWidget {
  final String svg;
  final String title;
  VoidCallback onClick;
  final Color color;

  CustomSideBarButton({
    Key? key,
    required this.svg,
    required this.title,
    required this.onClick, this.color = ColorsPalette.extraDarkGrey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Row(
        children: [
          SvgPicture.asset(
            svg,
            width: 10,
          ),
          UtilValues.gap4,
          Text(title ,

            style: TextStyle(
              color: color,
              fontSize: 13.sp,
            ),
          ),

        ],
      ),
    );
  }
}
