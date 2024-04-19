import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/assets_manager.dart';
import '../utils/colors_palette.dart';
import '../utils/helpers.dart';
import '../utils/size_config.dart';
import '../utils/util_values.dart';

class PopularItems extends StatelessWidget {

  final String imageUrl;
  final String name, description;
  final double price;
  final int qty;
  final int? index, points;
  final VoidCallback onTap;
  final int id;
  final double? width, height;


  const PopularItems({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.qty,
    required this.onTap,
    this.index,
    required this.id,
    required this.width,
    this.points, this.height
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //final borderRadius = UtilValues.borderRadius10.topLeft;
    return GestureDetector(
      key: ValueKey(id),
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: ColorsPalette.white,
          borderRadius: UtilValues.borderRadius10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: UtilValues.borderRadius5,
              child: CachedNetworkImage(  errorWidget: (context, url, error) => Container(height: 150.0, child: Icon(Icons.error),),

                imageUrl: imageUrl,
                height: 70,
                width: 90,
                fit: BoxFit.fill,
              ),
            ),
            UtilValues.gap4,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width!/2,
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorsPalette.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                UtilValues.gap8,
                SizedBox(
                  width: width!/2,
                  child: Text(
                    '$description $description$description$description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsPalette.extraDarkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}