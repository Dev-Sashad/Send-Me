import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../_lib.dart';

class InputFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? showMargin;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final bool? isMultiline;
  final bool? obscure;
  final bool? readOnly;
  final AutovalidateMode? autovalidateMode;
  final Color? fillColor;
  final Color? borderColor;
  final double? fontSize;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Function()? toggleShowPassword;
  final void Function()? onInfoPressed;
  final bool? showInfo;

  const InputFormField(
    this.label, {
    Key? key,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.hintText,
    this.onInfoPressed,
    this.showInfo = false,
    this.maxLines = 5,
    this.minLines = 2,
    this.controller,
    this.showMargin = true,
    this.isMultiline = false,
    this.obscure = false,
    this.maxLength,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.readOnly = false,
    this.fontSize = 14,
    this.focusNode,
    this.fillColor,
    this.borderColor,
    this.inputFormatters,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.suffixIcon,
    this.toggleShowPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(label!, textType: TextType.smallestText),
                  showInfo!
                      ? InkWell(
                          onTap: onInfoPressed,
                          child: const Icon(FontAwesomeIcons.info,
                              size: 15, color: AppColors.blue))
                      : horizontalSpace(0)
                ],
              )
            : verticalSpace(0),
        verticalSpace(label != null ? 5 : 0),
        Container(
          margin: showMargin!
              ? EdgeInsets.only(bottom: eqH(20))
              : EdgeInsets.only(bottom: eqH(0)),
          child: TextFormField(
            autovalidateMode: autovalidateMode,
            onChanged: onChanged,
            inputFormatters: inputFormatters ?? [],
            onSaved: onSaved,
            onTap: onTap,
            controller: controller,
            obscureText: obscure!,
            readOnly: readOnly!,
            focusNode: focusNode,
            validator: validator,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.textColor_1, fontSize: fontSize),
            textInputAction: isMultiline! ? null : textInputAction,
            maxLength: maxLength,
            maxLengthEnforcement: maxLengthEnforcement,
            keyboardType: isMultiline! ? TextInputType.multiline : keyboardType,
            minLines: isMultiline! ? minLines : null,
            maxLines: isMultiline!
                ? maxLines
                : obscure!
                    ? 1
                    : null,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.textColor_1),
              contentPadding: const EdgeInsets.only(left: 20),
              fillColor: fillColor ?? AppColors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.textFieldBorder.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color:
                      borderColor ?? AppColors.textFieldBorder.withOpacity(0.5),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color:
                      borderColor ?? AppColors.textFieldBorder.withOpacity(0.5),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color:
                      borderColor ?? AppColors.textFieldBorder.withOpacity(0.5),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color:
                      borderColor ?? AppColors.textFieldBorder.withOpacity(0.5),
                ),
              ),
              suffixIcon: toggleShowPassword != null
                  ? InkWell(
                      onTap: toggleShowPassword,
                      child: Icon(
                        obscure!
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: AppColors.deepGrey,
                        size: 20.sp,
                      ),
                    )
                  : suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
