import 'package:flutter/material.dart';
import '../../../_lib.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Consumer(builder: (context, ref, _) {
          final vm = ref.watch(loginVm);
          return SafeArea(
              child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: pad(horiz: 25, vert: 0),
                child: Column(children: [
                  verticalSpace(eqH(84)),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      "Hello there,",
                      color: AppColors.headerTextColor,
                      textType: TextType.headerText,
                    ),
                  ),
                  verticalSpace(eqH(8)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: eqW(304),
                      child: const CustomText(
                        "Let’s dive right in, input your details",
                        color: AppColors.textColor_1,
                        maxLines: 3,
                        textType: TextType.mediumText,
                      ),
                    ),
                  ),
                  verticalSpace(eqH(52)),
                  InputFormField("Email or Phone number",
                      controller: _emailCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      showMargin: false,
                      obscure: false, validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        emailorphoneRegEx(value)) {
                      return null;
                    } else {
                      return "enter a valid login details";
                    }
                  }),
                  verticalSpace(eqH(40)),
                  InputFormField("Password",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordCtrl,
                      obscure: vm.passVisible,
                      isMultiline: false,
                      toggleShowPassword: () => vm.setPassVisibility(),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "enter password";
                        } else {
                          return null;
                        }
                      }),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () => vm.forgotPass(context),
                        child: const CustomText("Forgot password",
                            color: AppColors.appBlue)),
                  ),
                  verticalSpace(eqH(50)),
                  CustomButton(
                      text: "Log in",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          vm.submit(
                              email: _emailCtrl.text.trim(),
                              password: _passwordCtrl.text.trim());
                        }
                      }),
                  verticalSpace(eqH(20)),
                  TextButton(
                      onPressed: () => vm.register(),
                      child: const CustomText(
                        "Sign Up",
                        textType: TextType.mediumText,
                        fontWeight: FontWeight.bold,
                        color: AppColors.appBlue,
                      ))
                ]),
              ),
            ),
          ));
        }),
      ),
    );
  }
}
