import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool enableFullScreenViewer;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.enableFullScreenViewer = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enableFullScreenViewer
          ? () {
        showImageViewer(
          context,
          CachedNetworkImageProvider(imageUrl),
        );
      }
          : null,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
