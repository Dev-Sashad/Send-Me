import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:send_me/_lib.dart';
import 'package:shimmer/shimmer.dart';

class LoaderWidget extends StatelessWidget {
  final double? height;
  final BoxShape? shape;
  final double? width;
  final EdgeInsetsGeometry? margin;
  const LoaderWidget(
      {this.height, this.shape = BoxShape.rectangle, this.width, this.margin});

  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.skyBlue,
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
  Screenloader(this.count);

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
                  height: eqH(100),
                  width: eqW(360),
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

class TransactionLoader extends StatelessWidget {
  final int count;
  TransactionLoader({this.count = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            count,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LoaderWidget(
                                height: 7,
                                width: eqW(80),
                              ),
                              verticalSpace(5),
                              LoaderWidget(
                                height: 9,
                                width: eqW(150),
                              ),
                              verticalSpace(5),
                              LoaderWidget(
                                height: 10,
                                width: eqW(200),
                              ),
                            ],
                          ),
                          LoaderWidget(
                            height: 10,
                            width: eqW(80),
                          ),
                        ],
                      ),
                      verticalSpace(5),
                      const Divider(
                        height: 9.0,
                        color: Color(0xFF00053A),
                      )
                    ],
                  ),
                )));
  }
}

class PlanLoader extends StatelessWidget {
  final int count;
  PlanLoader({this.count = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            count,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 0.2)
                        ],
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LoaderWidget(
                              height: 15,
                              width: eqW(80),
                            ),
                            verticalSpace(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LoaderWidget(
                                  height: 7,
                                  width: eqW(90),
                                ),
                                verticalSpace(5),
                                LoaderWidget(
                                  height: 10,
                                  width: eqW(60),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LoaderWidget(
                                    height: 7,
                                    width: eqW(90),
                                  ),
                                  verticalSpace(5),
                                  LoaderWidget(
                                    height: 10,
                                    width: eqW(60),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LoaderWidget(
                                    height: 7,
                                    width: eqW(90),
                                  ),
                                  verticalSpace(5),
                                  LoaderWidget(
                                    height: 10,
                                    width: eqW(60),
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                )));
  }
}

class WalletLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoaderWidget(
                height: eqH(100),
                width: eqW(100),
              ),
              // horizontalSpace(5),
              LoaderWidget(
                height: eqH(100),
                width: eqW(100),
              ),
              // horizontalSpace(5),
              LoaderWidget(
                height: eqH(100),
                width: eqW(100),
              )
            ],
          ),
          verticalSpace(50),
          TransactionLoader(count: 3)
        ],
      ),
    );
  }
}

planDetailsLoaderWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      children: [
        LoaderWidget(
          height: eqH(250),
          width: screenWidth - 50,
        ),
        verticalSpace(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoaderWidget(
                height: eqH(50),
                width: eqW(80),
              ),
              // horizontalSpace(5),
              LoaderWidget(
                height: eqH(50),
                width: eqW(80),
              ),
              // horizontalSpace(5),
              LoaderWidget(
                height: eqH(50),
                width: eqW(80),
              )
            ],
          ),
        ),
        verticalSpace(20),
        Screenloader(2)
      ],
    ),
  );
}

referalLoaderWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: [
        verticalSpace(20),
        LoaderWidget(
          height: eqH(200),
          width: screenWidth * 0.5,
        ),
        verticalSpace(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoaderWidget(
                height: eqH(50),
                width: eqW(100),
              ),
              // horizontalSpace(5),
              LoaderWidget(
                height: eqH(50),
                width: eqW(100),
              ),
            ],
          ),
        ),
        verticalSpace(20),
        Screenloader(2)
      ],
    ),
  );
}

class FetchingNameLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomText(
          'Loading',
          textType: TextType.smallestText,
          color: AppColors.blue,
        ),
        horizontalSpace(10),
        const SpinKitThreeBounce(
          color: AppColors.blue,
          size: 12.0,
          duration: Duration(milliseconds: 1200),
        )
      ],
    );
  }
}
