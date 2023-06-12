import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final BoxFit? fit;
  final double? height;
  final double? width;

  const CustomImage({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: fit,
      height: height,
      width: width,
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(
          value: progress.progress,
        ),
      ),
      errorWidget: (context, url, error) =>
          const FaIcon(FontAwesomeIcons.triangleExclamation),
    );
  }
}
