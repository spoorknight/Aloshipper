import '../configs/config.dart';
import 'loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageCustom extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double? borderRadius;
  final double sizeLoading;
  const CachedNetworkImageCustom({
    required this.url,
    this.width,
    this.height,
    this.boxFit,
    this.borderRadius,
    this.sizeLoading = 32,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: url?.isEmpty ?? true
          ? SizedBox(
              width: width,
              height: height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Assets.images.logo.image(),
              ),
            )
          : CachedNetworkImage(
              imageUrl: url!,
              width: width,
              height: height,
              alignment: Alignment.center,
              fit: boxFit ?? BoxFit.cover,
              placeholder: (context, url) => Loading(size: sizeLoading),
              errorWidget: (context, url, error) => FittedBox(
                  fit: BoxFit.cover, child: Assets.images.logo.image()),
            ),
    );
  }
}
