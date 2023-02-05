import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../_lib.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, _) {
        final vm = watch.watch(registerVm);
        return SafeArea(
            child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
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
                              verticalSpace(eqH(84)),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: CustomText("Sign up",
                                    color: AppColors.headerTextColor,
                                    textType: TextType.headerText),
                              ),
                              verticalSpace(eqH(8)),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  // width: eqW(304),
                                  alignment: Alignment.topLeft,
                                  child: const CustomText(
                                    "Register and start enjoying our nice offers",
                                    color: AppColors.headerTextColor,
                                    textType: TextType.mediumText,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              verticalSpace(eqH(30)),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  //  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int i = 0; i < 2; i++)
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
                                "Full name",
                                controller: vm.fullNameCtrl,
                                suffixIcon: const Icon(
                                  FontAwesomeIcons.user,
                                  color: AppColors.primaryColor,
                                  size: 15,
                                ),
                                validator: (input) {
                                  if (input == null || input.trim().isEmpty) {
                                    return 'enter name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              PhoneFormFieldWidget(
                                labelString: 'Phone Number',
                                initialCode: vm.code,
                                controller: vm.phoneNoCtrl,
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
                              verticalSpace(15),
                              InputFormField("Email",
                                  controller: vm.emailCtrl,
                                  obscure: false, validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !EmailValidator.validate(value) ||
                                    !value.contains("@")) {
                                  return "enter a valid email address";
                                } else {
                                  return null;
                                }
                              }),
                              verticalSpace(eqH(50)),
                              CustomButton(
                                  text: "Proceed",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      _formKey.currentState!.save();
                                      // if (vm.fullNameCtrl.text
                                      //     .toLowerCase()
                                      //     .contains('user not found')) {
                                      //   showOkayDialog(
                                      //       message: 'Invalid account name');
                                      //   return;
                                      // }
                                      vm.proceed();
                                    }
                                  }),
                              verticalSpace(eqH(20)),
                              TextButton(
                                  onPressed: () => vm.back(),
                                  child: const CustomText(
                                    "Back",
                                    color: AppColors.black,
                                    textType: TextType.mediumText,
                                  ))
                            ]),
                      ),
                    ))),
          ),
        ));
      }),
    );
  }
}
