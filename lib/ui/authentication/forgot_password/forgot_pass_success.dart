import 'package:flutter/material.dart';
import '../../../_lib.dart';

class ResetPassSuccess extends StatefulWidget {
  const ResetPassSuccess({Key? key}) : super(key: key);

  @override
  State<ResetPassSuccess> createState() => _ResetPassSuccessState();
}

class _ResetPassSuccessState extends State<ResetPassSuccess> {
  int value = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.regSuccesBckColor,
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Consumer(builder: (context, ref, _) {
          final vm = ref.watch(forgotPasswordVm);
          return SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Padding(
              padding: pad(
                horiz: eqW(40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.done,
                    size: 50,
                    color: AppColors.green,
                  ),
                  verticalSpace(eqH(50)),
                  const CustomText(
                    "Congratulations",
                    color: AppColors.white,
                    textType: TextType.headerText,
                  ),
                  verticalSpace(eqH(10)),
                  SizedBox(
                    width: eqW(304),
                    child: const CustomText(
                      "A reset password link has been sent to your mail",
                      color: AppColors.white,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      textType: TextType.mediumText,
                    ),
                  ),
                  verticalSpace(eqH(50)),
                  CustomButton(
                    onPressed: () {
                      for (int i = 0; i < 2; i++) {
                        Navigator.pop(context);
                      }
                    },
                    text: "Login",
                    fillColor: AppColors.white,
                    borderColor: AppColors.white,
                    textColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
