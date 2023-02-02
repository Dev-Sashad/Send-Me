import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

class PasswordCheckWidget extends StatelessWidget {
  final bool isValid;
  final String? text;

  PasswordCheckWidget({this.isValid = false, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20.0, top: 7.0),
      child: Row(
        children: [
          isValid
              ? const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.green, size: 10)
              : Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.textColor_1)),
                ),
          const SizedBox(width: 7.0),
          CustomText(text!,
              color: isValid ? Colors.green : AppColors.textlightGrey,
              textType: TextType.smallestText)
        ],
      ),
    );
  }
}
