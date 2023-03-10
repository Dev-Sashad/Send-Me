import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../../_lib.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final _formKey = GlobalKey<FormState>();

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
              padding: pad(horiz: eqW(40), vert: 0),
              child: Column(children: [
                verticalSpace(eqH(100)),
                const Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                    "Email Verification",
                    color: AppColors.headerTextColor,
                    textType: TextType.headerText,
                  ),
                ),
                verticalSpace(eqH(8)),
                const Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                    "We would send a link to this email for verification",
                    color: AppColors.headerTextColor,
                    maxLines: 3,
                    textType: TextType.mediumText,
                  ),
                ),
                verticalSpace(eqH(30)),
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
                    text: "Submit",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        vm.submit();
                      }
                    }),
                verticalSpace(eqH(20)),
                TextButton(
                    onPressed: () => vm.close,
                    child: const CustomText(
                      "Back",
                      color: AppColors.appBlue,
                      textType: TextType.mediumText,
                    ))
              ]),
            ),
          ),
        ));
      }),
    );
  }
}
