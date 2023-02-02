import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:send_me/_lib.dart';

class AssetsImage extends StatelessWidget {
  final String imgUrl;
  final BoxFit fit;
  final BoxShape shape;
  final double height;
  final double width;
  final double opacity;

  AssetsImage(
      {required this.imgUrl,
      this.fit = BoxFit.contain,
      this.shape = BoxShape.rectangle,
      this.height = 24,
      this.width = 24,
      this.opacity = 1.0});
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
          image: DecorationImage(
            image: AssetImage(imgUrl),
            fit: fit,
            opacity: opacity,
          ),
        ),
      );
}

class FileImage extends StatelessWidget {
  final File file;
  final BoxFit fit;
  final BoxShape shape;
  final double height;
  final double width;
  FileImage({
    required this.file,
    this.fit = BoxFit.contain,
    this.shape = BoxShape.rectangle,
    this.height = 24,
    this.width = 24,
  });

  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
        ),
        child: Image.file(
          file,
          height: height,
          width: width,
          fit: fit,
        ),
      );
}

class SvgImage extends StatelessWidget {
  final String imgUrl;
  final BoxFit fit;
  final BoxShape shape;
  final double height;
  final double width;
  final Color? color;
  SvgImage(
      {required this.imgUrl,
      this.fit = BoxFit.contain,
      this.shape = BoxShape.rectangle,
      this.height = 24,
      this.width = 24,
      this.color});
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
        ),
        child: SvgPicture.asset(
          imgUrl,
          fit: fit,
          color: color,
        ),
      );
}

class CacheNetworkImage extends StatelessWidget {
  final String imgUrl;
  final BoxFit? fit;
  final BoxShape shape;
  final double? height;
  final double? width;
  final Widget? errorWidget;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? radius;
  CacheNetworkImage({
    required this.imgUrl,
    this.fit,
    this.shape = BoxShape.rectangle,
    this.height,
    this.width,
    this.errorWidget,
    this.margin,
    this.radius,
  });
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: '$imgUrl',
        height: height,
        width: width,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              shape: shape,
              borderRadius: radius,
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          );
        },
        placeholder: (context, url) => Center(
            child: LoaderWidget(
                height: height!, width: width!, margin: margin!, shape: shape)),
        errorWidget: (context, url, error) {
          appPrint(
              '---cacheNetworkImage----url: $url -----error: $error ------');
          return errorWidget ??
              Center(
                child: Image.asset(
                  AppImages.logo,
                  height: 50,
                  width: 50,
                ),
              );
        },
      );
}
