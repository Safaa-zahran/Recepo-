import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/helpers.dart';
import 'package:posts_app/core/utils/util_values.dart';

class HorizontalListView extends StatelessWidget {
  final EdgeInsets padding;
  final int itemCount;
  final Widget Function(int) itemBuilder;
  final Widget separator;

  const HorizontalListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.separator = UtilValues.gap12,
    this.padding = UtilValues.paddingH16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Helpers.isEnglish(context)
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: SingleChildScrollView(
        physics: UtilValues.scrollPhysics,
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              for (int index = 0; index < 2 * itemCount - 1; index++)
                if (index.isEven) itemBuilder(index ~/ 2) else separator,
            ],
          ),
        ),
      ),
    );
  }
}
