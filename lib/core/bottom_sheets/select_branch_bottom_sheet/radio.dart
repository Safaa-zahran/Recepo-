import 'package:flutter/material.dart';

import '../../utils/colors_palette.dart';

class RadioCard extends StatelessWidget {
  RadioCard({Key? key, required this.value, required this.onChanged, required this.selectedValue}) : super(key: key);
  final int? value;
  final Function(int?)? onChanged;
  final int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Radio<int>(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      activeColor: ColorsPalette.primaryColor,
      value: value!,
      groupValue: selectedValue,
      onChanged: onChanged,
    );
  }
}
