import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textType = TextType.smallText,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextType? textType;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: setTextStyle.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  TextStyle get setTextStyle {
    switch (textType) {
      case TextType.headerText:
        return Theme.of(context).textTheme.headlineLarge!;

      case TextType.bigText:
        return Theme.of(context).textTheme.headlineMedium!;

      case TextType.largeText:
        return Theme.of(context).textTheme.titleMedium!;

      case TextType.mediumText:
        return Theme.of(context).textTheme.bodyLarge!;

      case TextType.smallText:
        return Theme.of(context).textTheme.bodyMedium!;

      case TextType.smallestText:
        return Theme.of(context).textTheme.bodySmall!;

      default:
        return Theme.of(context).textTheme.bodySmall!;
    }
  }
}
