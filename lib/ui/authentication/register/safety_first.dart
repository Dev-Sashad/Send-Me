import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../_lib.dart';

class RegFinal extends StatefulWidget {
  @override
  _RegFinalState createState() => _RegFinalState();
}

class _RegFinalState extends State<RegFinal> {
  final _formKey = GlobalKey<FormState>();
  bool _contains8Char = false;
  bool _hasMatch = false;
  bool _containNumberandChar = false;
  bool _containsCaps = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final vm = ref.watch(registerVm);

        return SafeArea(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: pad(horiz: 25, vert: 0),
                  child: AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                          children: [
                            verticalSpace(eqH(40)),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: CustomText("Safety first",
                                  color: AppColors.headerTextColor,
                                  textType: TextType.headerText),
                            ),
                            verticalSpace(eqH(8)),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  "You almost done, setup your password.",
                                  color: AppColors.headerTextColor,
                                  textType: TextType.mediumText),
                            ),
                            verticalSpace(eqH(30)),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (int i = 0; i < 3; i++)
                                    vm.currentIndex == i
                                        ? pageIndicator(
                                            true,
                                            i,
                                            onTap: () {},
                                          )
                                        : pageIndicator(
                                            false,
                                            i,
                                            onTap: () {},
                                          )
                                ],
                              ),
                            ),
                            verticalSpace(eqH(20)),
                            InputFormField(
                              "Password",
                              controller: vm.passwordCtrl,
                              obscure: vm.passVisible,
                              toggleShowPassword: () => vm.setPassVisibility(),
                              onChanged: (value) {
                                if (value!.trim().contains(RegExp(r'[0-9]'))) {
                                  setState(() {
                                    _containNumberandChar = true;
                                  });
                                } else if (!value
                                    .trim()
                                    .contains(RegExp(r'[0-9]'))) {
                                  setState(() {
                                    _containNumberandChar = false;
                                  });
                                }
                                if (value.trim().contains(RegExp(r'[A-Z]'))) {
                                  setState(() {
                                    _containsCaps = true;
                                  });
                                } else if (!value
                                    .trim()
                                    .contains(RegExp(r'[A-Z]'))) {
                                  setState(() {
                                    _containsCaps = false;
                                  });
                                }
                                if (value.trim().length > 7) {
                                  setState(() {
                                    _contains8Char = true;
                                  });
                                } else if (value.trim().length < 8) {
                                  setState(() {
                                    _contains8Char = false;
                                  });
                                }

                                if (vm.confirmPasswordCtrl.text
                                        .trim()
                                        .isNotEmpty &&
                                    vm.confirmPasswordCtrl.text.trim() ==
                                        vm.passwordCtrl.text.trim()) {
                                  setState(() {
                                    _hasMatch = true;
                                  });
                                } else if (vm.confirmPasswordCtrl.text
                                        .trim()
                                        .isEmpty ||
                                    vm.confirmPasswordCtrl.text.trim() !=
                                        vm.passwordCtrl.text.trim()) {
                                  setState(() {
                                    _hasMatch = false;
                                  });
                                }
                              },
                            ),
                            InputFormField("Confirm password",
                                controller: vm.confirmPasswordCtrl,
                                obscure: vm.passVisible,
                                toggleShowPassword: () =>
                                    vm.setPassVisibility(),
                                onChanged: (value) {
                                  if (value != null &&
                                      value.isNotEmpty &&
                                      vm.confirmPasswordCtrl.text.trim() ==
                                          vm.passwordCtrl.text.trim()) {
                                    setState(() {
                                      _hasMatch = true;
                                    });
                                  } else {
                                    setState(() {
                                      _hasMatch = false;
                                    });
                                  }
                                }),
                            verticalSpace(eqH(24)),
                            PasswordCheckWidget(
                                text: "Must contain a capital letter",
                                isValid: _containsCaps),
                            PasswordCheckWidget(
                                text: "Must be upto 8 letters",
                                isValid: _contains8Char),
                            PasswordCheckWidget(
                                text: "Must contain numbers or characters",
                                isValid: _containNumberandChar),
                            PasswordCheckWidget(
                                text: "Password match", isValid: _hasMatch),
                            verticalSpace(eqH(50)),
                            CustomButton(
                                text: "Submit",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    FocusScope.of(context).unfocus();
                                    vm.submit();
                                  }
                                }),
                            verticalSpace(eqH(20)),
                            TextButton(
                                onPressed: () => vm.back(),
                                child: const CustomText("Back",
                                    color: AppColors.appBlue,
                                    textType: TextType.mediumText))
                          ]),
                    ),
                  ),
                ))));
      }),
    );
  }
}
