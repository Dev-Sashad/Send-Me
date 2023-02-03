import 'package:flutter/material.dart';
import '../../../_lib.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DialogCustomContainer(
      child: BaseScaffold(
        backgroundColor: Colors.transparent,
        useRowAppBar: false,
        showLeading: false,
        title: "Forgot password",
        subTitle:
            "Can’t recall your password? enter your registered email address",
        child: Consumer(builder: (context, ref, _) {
          final vm = ref.watch(forgotPasswordVm);
          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: CustomScrollWidget(
              child: Padding(
                padding: pad(horiz: eqW(35), vert: 0),
                child: Column(children: [
                  // verticalSpace(eqH(100)),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: CustomText(
                  //     "Forgot password",
                  //     color: AppColors.headerTextColor,
                  //     textType: TextType.headerText,
                  //   ),
                  // ),
                  // verticalSpace(eqH(8)),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Container(
                  //     child: CustomText(
                  //       "Can’t recall your password? enter your registered email address",
                  //       color: AppColors.headerTextColor,
                  //       maxLines: 3,
                  //       textType: TextType.mediumText,
                  //     ),
                  //   ),
                  // ),
                  verticalSpace(eqH(10)),
                  InputFormField("Email/Phone number",
                      controller: _emailCtrl,
                      obscure: false, validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        emailorphoneRegEx(value)) {
                      return null;
                    } else {
                      return "enter a valid login details";
                    }
                  }),
                  verticalSpace(eqH(44)),
                  CustomButton(
                      text: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          vm.sendResetPasswordLink(context: context);
                        }
                      }),
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
