import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/utils/mixins/ui_tool_mixin.dart';

class SendItemScreen extends StatefulWidget {
  const SendItemScreen({Key? key}) : super(key: key);

  @override
  _SendItemScreenState createState() => _SendItemScreenState();
}

class _SendItemScreenState extends State<SendItemScreen> with UIToolMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      child: Consumer(builder: (context, watch, _) {
        final vm = watch.watch(sendItemVm);
        return Scaffold(
            backgroundColor: AppColors.white,
            body: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20),
                    const BackButton(),
                    verticalSpace(20),
                    const CustomText(
                      'Send Item',
                      textType: TextType.largeText,
                    ),
                    verticalSpace(20),
                    InputFormField("Pick address",
                        controller: vm.pkAddCtrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        showMargin: false,
                        obscure: false, validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "enter a valid pick address";
                      }
                    }),
                    verticalSpace(10),
                    InputFormField("Drop-off address",
                        controller: vm.dpAddressCtrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        showMargin: false,
                        obscure: false, validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "enter a valid drop-off address";
                      }
                    }),
                    verticalSpace(10),
                    PhoneFormFieldWidget(
                      labelString: 'Receiver\'s number',
                      readOnly: true,
                      initialCode: vm.code,
                      controller: vm.numberCtrl,
                      keyBoardShow: TextInputType.number,
                      textAction: TextInputAction.next,
                      textHint: "8100123456",
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'enter valid phone number';
                        } else if (v.length < 10 || v.length > 11) {
                          return 'enter valid phone number';
                        } else if (!phoneRegEx(v)) {
                          return 'enter valid phone number';
                        } else {
                          return null;
                        }
                      },
                      onCountryChange: (e) => vm.setCode(e.code!),
                      onSaved: (nm) => vm.setNumber(nm!),
                    ),
                    verticalSpace(eqH(50)),
                    CustomButton(
                        text: vm.estimated ? "Proceed" : "Estimate price",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            FocusScope.of(context).unfocus();
                            if (vm.estimated) {
                              vm.submit();
                            } else {
                              vm.estimate();
                            }
                          }
                        }),
                    verticalSpace(eqH(20)),
                  ]),
            ));
      }),
    );
  }
}
