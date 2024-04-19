import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/colors_palette.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  final double size;

  const LoadingWidget({
    Key? key,
    this.color = ColorsPalette.primaryColor,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      size: size,
      color: color,
    );
  }
}
