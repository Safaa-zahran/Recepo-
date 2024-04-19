import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:posts_app/core/widgets/contained_icon_button.dart';

class QuantityController extends StatelessWidget {
  final int quantity;
  final VoidCallback decreaseQuantity;
  final VoidCallback increaseQuantity;

  const QuantityController({
    Key? key,
    required this.quantity,
    required this.decreaseQuantity,
    required this.increaseQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainedIconButton(
          icon: const Icon(Icons.remove, color: ColorsPalette.white,),
          backgroundColor: ColorsPalette.primaryColor,
          //iconColor: ColorsPalette.white,
          onTap: decreaseQuantity,
        ),
        UtilValues.gap24,
        Text(
          quantity.toString(),
          style: const TextStyle(
            color: ColorsPalette.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        UtilValues.gap24,
        ContainedIconButton(
          icon: const Icon(Icons.add, color: ColorsPalette.white),
          backgroundColor: ColorsPalette.primaryColor,
          //iconColor: ColorsPalette.white,
          onTap: increaseQuantity,
        ),
      ],
    );
  }
}
