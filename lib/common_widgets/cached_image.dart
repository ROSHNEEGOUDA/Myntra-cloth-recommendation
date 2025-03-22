import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? height;
  final double width;
  final BoxShape shape;

  const CachedImage({
    Key? key,
    required this.url,
    this.height,
    this.width = double.infinity,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(8) : null,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageProvider,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(8) : null,
        ),
        child: Image.asset(
          'assets/images/blank_image.png',
          fit: BoxFit.cover,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(8) : null,
        ),
        child: Image.asset(
          'assets/images/blank_image.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
