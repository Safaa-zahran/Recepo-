import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/colors_palette.dart';

class CustomReply extends StatelessWidget {
  const CustomReply(
      {
        Key? key,
        required this.nameAuthor,
        required this.title,
        required this.description,
        required this.voidCallbackUpvote,})
      : super(key: key);
  final String nameAuthor;
  final String title;
  final String description;
  final VoidCallback voidCallbackUpvote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 16.h,
          width: double.infinity,
          padding: UtilValues.padding8,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.1),
              borderRadius: UtilValues.borderRadius10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameAuthor,
                style: TextStyle(
                    color: ColorsPalette.primaryColor,
                    fontSize: 12.sp),
              ),
              UtilValues.gap8,
              Text(
                description,
                style: TextStyle(
                    color: ColorsPalette.darkGrey,
                    fontSize: 10.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

TextEditingController controller = TextEditingController();
FocusNode node = FocusNode();
