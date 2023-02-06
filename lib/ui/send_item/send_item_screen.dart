import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Consumer(builder: (context, watch, _) {
      final vm = watch.watch(sendItemVm);
      return SafeArea(
        bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: CustomScrollWidget(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        InkWell(
                          onTap: () => navigationService.pop(),
                          child: const Icon(
                            FontAwesomeIcons.chevronLeft,
                            size: 20,
                            color: AppColors.black,
                          ),
                        ),
                        verticalSpace(20),
                        const CustomText(
                          'Send Item',
                          textType: TextType.bigText,
                          fontWeight: FontWeight.bold,
                        ),
                        verticalSpace(20),
                        InputFormField("Pick address",
                            controller: vm.pkAddCtrl,
                            readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            showMargin: false,
                            onTap: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                currentFocus.focusedChild!.unfocus();
                              }
                              final p = await vm.getPrediction();
                              final data = await vm.displayPredict(
                                p,
                                context,
                              );
                              if (data.formattedAddress!.trim().isNotEmpty) {
                                vm.setPickUp(data);
                                vm.setEstimated(false);
                              }
                            },
                            suffixIcon: const Icon(Icons.location_on,
                                color: AppColors.textlightGrey),
                            obscure: false,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              } else {
                                return "enter a valid pick address";
                              }
                            }),
                        verticalSpace(10),
                        InputFormField("Drop-off address",
                            controller: vm.dpAddressCtrl,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            showMargin: false,
                            onTap: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                currentFocus.focusedChild!.unfocus();
                              }
                              final p = await vm.getPrediction();
                              final data = await vm.displayPredict(
                                p,
                                context,
                              );
                              if (data.formattedAddress!.trim().isNotEmpty) {
                                vm.setDropOff(data);
                                vm.setEstimated(false);
                              }
                            },
                            suffixIcon: const Icon(
                              Icons.location_on,
                              color: AppColors.textlightGrey,
                            ),
                            obscure: false,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              } else {
                                return "enter a valid drop-off address";
                              }
                            }),
                        verticalSpace(10),
                        PhoneFormFieldWidget(
                          labelString: 'Receiver\'s number',
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
                        verticalSpace(10),
                        InputFormField("Weight",
                            controller: vm.weightCtrl,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: CustomText('Kg'),
                            ),
                            onChanged: (v) => vm.setEstimated(false),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            showMargin: false,
                            obscure: false,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              } else {
                                return "what'/s the weight of the item?";
                              }
                            }),
                        verticalSpace(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText('Distance:'),
                            CustomText(
                              "${vm.distance} km",
                              textType: TextType.largeText,
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText('Delivery Cost:'),
                            CustomText(
                              currencyFormater(vm.fee.toString(),
                                  symbol: "USD "),
                              textType: TextType.largeText,
                            ),
                          ],
                        ),
                        verticalSpace(eqH(50)),
                        CustomButton(
                            text: vm.estimated ? "Submit" : "Estimate price",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                FocusScope.of(context).unfocus();
                                if (vm.estimated) {
                                  vm.submit();
                                } else {
                                  vm.estimateCost();
                                }
                              }
                            }),
                        verticalSpace(eqH(20)),
                      ]),
                ),
              ),
            )),
      );
    });
  }
}
