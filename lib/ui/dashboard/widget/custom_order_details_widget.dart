import 'package:flutter/material.dart';
import 'package:send_me/constants/_constant.dart';
import 'package:send_me/widgets/text_widget.dart';

class CustomOrderDetails extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Color? subtitleColor;
  final double? subTitleFontsize;
  const CustomOrderDetails(
      {Key? key,
      this.subTitle,
      this.subTitleFontsize,
      this.subtitleColor = AppColors.black,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title ?? "",
            textType: TextType.smallText,
          ),
          SizedBox(
            width: eqW(230),
            child: CustomText(
              subTitle ?? "",
              maxLines: 3,
              textAlign: TextAlign.left,
              fontSize: subTitleFontsize,
              textType: TextType.mediumText,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
