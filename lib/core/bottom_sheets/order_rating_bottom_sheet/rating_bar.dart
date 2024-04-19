import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';

class LabeledRatingBar extends StatelessWidget {
  final String label;
  final Function(double rating) onRatingChange;

  const LabeledRatingBar({
    super.key,
    required this.label,
    required this.onRatingChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: ColorsPalette.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        UtilValues.gap16,
        RatingBar.builder(
          minRating: 1,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemSize: 32,
          unratedColor: ColorsPalette.grey,
          onRatingUpdate: onRatingChange,
        ),
      ],
    );
  }
}
