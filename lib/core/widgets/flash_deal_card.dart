import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/helpers.dart';
import 'package:posts_app/core/utils/util_values.dart';

import '../utils/assets_manager.dart';

class FlashDealCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String name, description;
  final DateTime validUntil;
  final double price;
  final VoidCallback onTap;
  final double? width, height;

  const FlashDealCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.validUntil,
    required this.price,
    required this.onTap,
    required this.description,
    this.width, this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int l = name.split(' ').length;
    return GestureDetector(
      key: ValueKey(id),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: width == null
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: UtilValues.borderRadius15,
            child: CachedNetworkImage(  errorWidget: (context, url, error) => SizedBox(height: 150.0, child: const Icon(Icons.error),),

                imageUrl: imageUrl,
                width: width,
                height: height,
                fit: BoxFit.fill
            ),
          ),
          Container(
            width: width,
            padding: UtilValues.padding4,
            child: Row(
              crossAxisAlignment: width == null
                  ? CrossAxisAlignment.stretch
                  : CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    //decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 15,
                  child: SlideCountdownSeparated(
                    /*textDirection: Helpers.isEnglish(context)
                        ? TextDirection.ltr
                        : TextDirection.rtl,*/
                    decoration: BoxDecoration(
                      color: ColorsPalette.white,
                      borderRadius: UtilValues.borderRadius5,
                    ),
                    textStyle: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: ColorsPalette.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    duration: validUntil.difference(DateTime.now()),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}