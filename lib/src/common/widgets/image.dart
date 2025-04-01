import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomImage extends StatelessWidget {
  final String img;
  final double width;
  final double height;
  final double radius;
  final BoxFit fit;
  final bool? isNetwork;
  final bool openImage;
  final Color? color;
  const CustomImage(
    this.img, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.radius = 8,
    this.fit = BoxFit.cover,
    this.color,
    this.isNetwork,
    this.openImage = false,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          if (isNetwork == true && openImage == true) {
            final imageProvider = Image.network(img).image;
            showImageViewer(context, imageProvider, onViewerDismissed: () {});
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Colors.grey.shade200,
          ),
          width: width,
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: (img.contains('com.shugaentertainment.shuga/cache'))
                ? Image.file(
                    File(img),
                    width: width,
                    height: height,
                    fit: fit,
                    color: color,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Iconsax.gallery_slash_outline),
                  )
                : isNetwork == true
                    ? Image.network(
                        img,
                        width: width,
                        height: height,
                        fit: fit,
                        color: color,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Iconsax.gallery_slash_outline),
                      )
                    : Image.asset(
                        img,
                        width: width,
                        height: height,
                        fit: fit,
                        color: color,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Iconsax.gallery_slash_outline),
                      ),
          ),
        ),
      );
}

class SvgImage extends StatelessWidget {
  final String svgPath;
  final double width;
  final double height;
  final Color? color;
  final BoxFit fit;
  final bool? isUrl;

  const SvgImage(
    this.svgPath, {
    super.key,
    this.width = 100.0,
    this.height = 100.0,
    this.color,
    this.isUrl = false,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) => isUrl == true
      ? SvgPicture.network(
          svgPath,
          width: width,
          height: height,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          fit: fit,
        )
      : SvgPicture.asset(
          svgPath,
          width: width,
          height: height,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          fit: fit,
        );
}
