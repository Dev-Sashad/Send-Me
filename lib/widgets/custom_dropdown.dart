import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:send_me/_lib.dart';

class CustomDropDown extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final String? value;
  final String hintText;
  final List<String> items;
  final void Function(String?)? onChanged;
  CustomDropDown(
      {this.borderColor,
      required this.items,
      required this.hintText,
      this.onChanged,
      this.padding,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border:
              Border.all(color: borderColor ?? AppColors.blue.withOpacity(.8))),
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: eqW(24), vertical: 14),
      alignment: Alignment.centerLeft,
      child: DropdownButton<String>(
          elevation: 0,
          underline: Container(),
          value: value,
          hint: CustomText(
            hintText,
            textType: TextType.mediumText,
          ),
          isExpanded: true,
          style: Theme.of(context).textTheme.displayLarge,
          dropdownColor: AppColors.skyBlue,
          icon:
              const Icon(FontAwesomeIcons.angleDown, color: AppColors.appBlue),
          items: items.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: value == e
                    ? AppColors.blue.withOpacity(.8)
                    : Colors.transparent,
                alignment: Alignment.centerLeft,
                child: CustomText(
                  e,
                ),
              ),
              value: value,
            );
          }).toList(),
          onChanged: onChanged),
    );
  }
}
