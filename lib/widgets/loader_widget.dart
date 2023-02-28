import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:shimmer/shimmer.dart';

class LoaderWidget extends StatelessWidget {
  final double? height;
  final BoxShape? shape;
  final double? width;
  final EdgeInsetsGeometry? margin;
  const LoaderWidget(
      {Key? key,
      this.height,
      this.shape = BoxShape.rectangle,
      this.width,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 1500),
        highlightColor: AppColors.grey,
        child: Container(
          height: height ?? 100,
          width: width ?? 100,
          margin: margin ?? const EdgeInsets.all(1),
          //padding: pad(both: 15),
          decoration: BoxDecoration(
            shape: shape!,
            borderRadius:
                shape == BoxShape.circle ? null : BorderRadius.circular(10),
            color: Colors.grey[100],
          ),
        ));
  }
}

class Screenloader extends StatelessWidget {
  final int count;
  const Screenloader(this.count, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            count,
            (index) => Shimmer.fromColors(
                baseColor: Colors.grey[200] ?? Colors.grey,
                direction: ShimmerDirection.ltr,
                period: const Duration(milliseconds: 800),
                highlightColor: Colors.white,
                child: Container(
                  height: eqH(80),
                  width: screenWidth,
                  margin: EdgeInsets.only(
                      bottom: eqH(15), right: eqW(10), left: eqW(10)),
                  //padding: pad(both: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.grey,
                  ),
                ))));
  }
}
