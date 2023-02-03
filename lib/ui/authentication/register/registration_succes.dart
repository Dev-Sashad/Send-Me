import 'package:flutter/material.dart';
import '../../../_lib.dart';

class RegistrationSuccess extends StatefulWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  State<RegistrationSuccess> createState() => _RegistrationSuccessState();
}

class _RegistrationSuccessState extends State<RegistrationSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.regSuccesBckColor,
      resizeToAvoidBottomInset: false,
      body: Consumer(builder: (context, ref, _) {
        final vm = ref.watch(registerVm);
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(
                left: eqW(40), right: eqW(40), top: eqH(50), bottom: eqH(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(eqH(70)),
                      const CustomText(
                        "Congratulations",
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        textType: TextType.headerText,
                      ),
                      verticalSpace(eqH(10)),
                      const CustomText(
                        "Your profile is almost complete. Update the following for a better experience",
                        maxLines: 3,
                        color: AppColors.white,
                        textType: TextType.mediumText,
                      ),
                      verticalSpace(eqH(30)),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () => vm.navigateHome(),
                      child: const CustomText("Skip",
                          color: AppColors.white,
                          textType: TextType.mediumText)),
                )
              ],
            ),
          )),
        );
      }),
    );
  }

  Widget _customWidget({void Function()? onTap, String? text}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.white),
          ),
          horizontalSpace(10),
          CustomText(
            text!,
            color: AppColors.appBlue,
            textType: TextType.mediumText,
          ),
        ],
      ),
    );
  }
}
