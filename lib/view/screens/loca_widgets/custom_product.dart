import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:sizer/sizer.dart';

class CustomProductWidget extends StatelessWidget {
  final String title;
  final String image;
  final int price;
  final VoidCallback voidCallbackUpvote;
  final VoidCallback voidCallbackUpdate;
  final int numberOfReplies;
  final bool allPosts;
  // this attributes will be increase

  const CustomProductWidget(
      {super.key,
      required this.title,
      required this.price,
      required this.voidCallbackUpvote,
      required this.voidCallbackUpdate,
      required this.numberOfReplies,
      required this.allPosts,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        elevation: 3,
        borderRadius: UtilValues.borderRadius10,
        child: Container(
          padding: UtilValues.padding8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: UtilValues.borderRadius10,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.04),
                  blurRadius: 40.sp,
                  offset: Offset(0, 6),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: ColorsPalette.customGrey, fontSize: 20.sp),
                      ),
                      Text(
                        price.toString(),
                        style: TextStyle(color: Colors.purple, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),

              // end title section

              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: voidCallbackUpvote,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: ColorsPalette.red,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: voidCallbackUpdate,
                    icon: const Icon(
                      Icons.edit,
                      color: ColorsPalette.darkGrey,
                      size: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
