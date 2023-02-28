import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../_lib.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool useRowAppBar;
  final String? bckImage;
  final bool showTitle;
  final bool showTrailing;
  final bool showLeading;
  final bool showDivider;
  final bool enableScroll;
  final double topPadding;
  final bool showSubTitle;
  final Widget child;
  final Widget? suffixIcon;
  final void Function()? onMenuPressed;
  final Color? backgroundColor;
  final void Function()? onPop;
  const BaseScaffold(
      {Key? key,
      this.title = "",
      this.subTitle = "",
      this.useRowAppBar = true,
      this.bckImage,
      this.topPadding = 30,
      this.showSubTitle = true,
      this.showTitle = true,
      this.showLeading = true,
      this.showTrailing = true,
      this.enableScroll = true,
      this.showDivider = false,
      required this.child,
      this.suffixIcon,
      this.onPop,
      this.onMenuPressed,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            bckImage != null
                ? Container(
                    height: eqH(331),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(bckImage!),
                            fit: BoxFit.fitWidth)),
                  )
                : Container(),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: eqW(10), right: eqW(20), top: eqH(0)),
                  child: useRowAppBar
                      ? _appBar(
                          title: title,
                          showTitle: showTitle,
                          onPop: () => Navigator.pop(context),
                          showLeading: showLeading,
                          showTrailing: showTrailing,
                          suffixIcon: suffixIcon!,
                          onMenuPressed: onMenuPressed!)
                      : _cancleAppBar(
                          onPop: onPop ?? () => Navigator.pop(context),
                          title: title,
                          subTitle: subTitle,
                          showDivider: showDivider,
                          showSubTitle: showSubTitle,
                          showTitle: showTitle),
                ),
                showSubTitle ? verticalSpace(30) : verticalSpace(0),
                Expanded(child: child)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appBar(
    {String title = "",
    void Function()? onMenuPressed,
    void Function()? onPop,
    Widget? suffixIcon,
    bool showTitle = true,
    bool showLeading = true,
    bool showTrailing = true}) {
  return Row(
    mainAxisAlignment:
        showLeading ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
    children: [
      showLeading
          ? BackButton(
              onPressed: onPop,
              color: AppColors.headerTextColor,
            )
          : horizontalSpace(0),
      showTitle
          ? CustomText(
              title,
              color: AppColors.headerTextColor,
              textType: TextType.bigText,
              fontWeight: FontWeight.w600,
            )
          : horizontalSpace(eqW(20)),
      showTrailing
          ? suffixIcon ??
              InkWell(
                  onTap: onMenuPressed,
                  child: Icon(
                    Icons.adjust,
                    size: 20.sp,
                  ))
          : horizontalSpace(eqW(20)),
    ],
  );
}

Widget _cancleAppBar(
    {String? title,
    void Function()? onPop,
    String? subTitle,
    bool showTitle = true,
    bool showSubTitle = true,
    bool showDivider = false}) {
  return Container(
    padding: const EdgeInsets.only(left: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: onPop,
                child: Icon(
                  Icons.close,
                  size: 30.sp,
                  color: Theme.of(context).colorScheme.primary,
                ))),
        verticalSpace(eqH(48)),
        showTitle
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title ?? "",
                    color: AppColors.headerTextColor,
                    textType: TextType.bigText,
                    fontWeight: FontWeight.w600,
                  ),
                  showSubTitle ? verticalSpace(eqH(8)) : verticalSpace(0),
                  showSubTitle
                      ? SizedBox(
                          width: screenWidth * 0.75,
                          child: CustomText(
                            subTitle ?? "",
                            maxLines: 3,
                            color: AppColors.textColor_1,
                            textType: TextType.smallText,
                          ),
                        )
                      : verticalSpace(0),
                  showDivider
                      ? Column(
                          children: [
                            verticalSpace(5),
                            Divider(
                              color: AppColors.textFieldBorder,
                            ),
                          ],
                        )
                      : verticalSpace(0)
                ],
              )
            : Container(),
      ],
    ),
  );
}
