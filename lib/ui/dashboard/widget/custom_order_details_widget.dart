import 'package:flutter/material.dart';
import 'package:send_me/constants/_constant.dart';
import 'package:send_me/widgets/text_widget.dart';

class CustomOrderDetails extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Color? subtitleColor;
  const CustomOrderDetails(
      {Key? key,
      this.subTitle,
      this.title,
      this.subtitleColor = AppColors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            title ?? "",
            textType: TextType.mediumText,
          ),
          SizedBox(
            width: eqW(200),
            child: CustomText(
              title ?? "",
              textType: TextType.largeText,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
