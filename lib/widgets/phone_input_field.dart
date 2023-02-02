import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:send_me/_lib.dart';

class PhoneFormFieldWidget extends StatefulWidget {
  final String? labelString;
  final String? initialCode;
  final AutovalidateMode autovalidateMode;
  final double fontSize;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final bool showFlag;
  final FocusNode? focusNode;
  final Function(PhoneInputItems)? onCountryChange;
  final TextInputType keyBoardShow;
  final TextInputAction? textAction;
  final Widget? suffixIcon;
  final String? textHint;
  final bool readOnly;
  final bool showBottomMargin;

  const PhoneFormFieldWidget(
      {Key? key,
      this.labelString,
      this.initialCode,
      this.showBottomMargin = false,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.controller,
      this.validator,
      this.showFlag = true,
      this.readOnly = false,
      this.onChanged,
      this.onSaved,
      this.fontSize = 12,
      this.focusNode,
      this.keyBoardShow = TextInputType.number,
      this.textAction,
      this.textHint,
      this.suffixIcon,
      this.onCountryChange})
      : super(key: key);

  @override
  _PhoneFormFieldWidgetState createState() => _PhoneFormFieldWidgetState();
}

class _PhoneFormFieldWidgetState extends State<PhoneFormFieldWidget> {
  List<PhoneInputItems> country = [
    PhoneInputItems(code: '+234', icon: AppCountry.ngn),
    // PhoneInputItems(code: '+233', icon: AppCountry.gh),
  ];
  @override
  Widget build(BuildContext context) {
    PhoneInputItems _hint =
        country.where((e) => widget.initialCode == e.code).first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelString != null
            ? CustomText(widget.labelString!, textType: TextType.smallestText)
            : verticalSpace(0),
        verticalSpace(widget.labelString != null ? 5 : 0),
        Container(
          margin:
              EdgeInsets.only(bottom: eqH(widget.showBottomMargin ? 20 : 0)),
          child: TextFormField(
            autovalidateMode: widget.autovalidateMode,
            textInputAction: widget.textAction,
            controller: widget.controller,
            validator: widget.validator,
            readOnly: widget.readOnly,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: widget.keyBoardShow,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.textColor_1, fontSize: widget.fontSize),
            onSaved: widget.onSaved,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
                prefixIcon: Container(
                    padding: EdgeInsets.only(left: eqW(10), right: eqW(10)),
                    width: 100,
                    child: PopupMenuButton<PhoneInputItems>(
                        offset: const Offset(-10, 50),
                        shape: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: [
                            CustomText(
                              _hint.code!,
                              textType: TextType.smallestText,
                            ),
                            horizontalSpace(widget.showFlag ? 10 : 0),
                            widget.showFlag
                                ? Image.asset(
                                    _hint.icon!,
                                    height: eqW(30),
                                    width: eqW(30),
                                  )
                                : horizontalSpace(0)
                          ],
                        ),
                        onSelected: widget.onCountryChange,
                        itemBuilder: (context) => country
                            .map(
                              (value) => PopupMenuItem<PhoneInputItems>(
                                value: value,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  // margin: EdgeInsets.only(top: isFirst ? 30 : 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        value.code!,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      horizontalSpace(10),
                                      Image.asset(
                                        value.icon!,
                                        height: 30,
                                        width: 30,
                                        alignment: Alignment.bottomCenter,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList())),
                contentPadding: const EdgeInsets.only(left: 20),
                fillColor: AppColors.skyBlue,
                filled: true,
                hintText: widget.labelString,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.appBlue, fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                suffixIcon: widget.suffixIcon),
          ),
        ),
      ],
    );
  }
}

class PhoneInputItems {
  String? code;
  String? icon;
  PhoneInputItems({this.code, this.icon});
}
