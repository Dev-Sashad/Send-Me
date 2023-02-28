import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_me/_lib.dart';

class Onboarding extends StatelessWidget {
  final String? imgUrl;
  final String? title;
  final String? desc;
  const Onboarding({Key? key, this.imgUrl, this.title, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imgUrl!))),
            height: screenHeight * 0.5,
            width: screenWidth,
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: CustomText(
                title!,
                color: AppColors.primaryColor,
                textType: TextType.largeText,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            CustomText(
              desc!,
              color: AppColors.primaryColor,
              textType: TextType.largeText,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            )
          ],
        ),
      ],
    );
  }
}
