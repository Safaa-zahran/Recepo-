import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/util_values.dart';

import '../utils/font.dart';

class OrderStatusChip extends StatelessWidget {
  final int status;

  const OrderStatusChip({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color, labelColor;
    String label;

    // 0 => 'inCart',
    // 1 => 'waiting',
    // 2 => 'canceled',
    // 3 => 'inKitchen',
    // 4 => 'ready',
    // 5 => 'assigned',
    // 6 => 'driverCanceled',
    // 7 => 'onWay',
    // 8 => 'delivered',

    switch (status) {
      case 1:
        color = ColorsPalette.lightGrey;
        label = LocaleKeys.freelance.tr();
        labelColor = ColorsPalette.black;
        break;
      case 2:
        color = ColorsPalette.red;
        label = LocaleKeys.canceled.tr();
        labelColor = ColorsPalette.lightGrey;

        break;
      case 3:
        color = ColorsPalette.yellow;
        label = LocaleKeys.remote.tr();
        labelColor = ColorsPalette.black;
        break;
      case 4:
        color = ColorsPalette.yellow;
        label = LocaleKeys.ready.tr();
        labelColor = ColorsPalette.lightGrey;

        break;
      case 5:
        color = ColorsPalette.yellow;
        label = LocaleKeys.driverAssigned.tr();
        labelColor = ColorsPalette.lightGrey;

        break;
      case 6:
      case 7:
        color = ColorsPalette.yellow;
        label = LocaleKeys.onWay.tr();
        labelColor = ColorsPalette.lightGrey;

        break;
      case 8:
        color = ColorsPalette.green;
        label = LocaleKeys.publish.tr();
        labelColor = ColorsPalette.lightGrey;

        break;
      default:
        color = ColorsPalette.yellow;
        label = LocaleKeys.preparing.tr();
        labelColor = ColorsPalette.lightGrey;

    }

    return Container(
      padding: UtilValues.padding8V12H,
      decoration: BoxDecoration(
        borderRadius: UtilValues.borderRadius25,
        color: color,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: NSTextStyles.font,
          color: labelColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
