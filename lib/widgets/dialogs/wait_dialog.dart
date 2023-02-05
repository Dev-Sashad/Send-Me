import 'package:flutter/material.dart';
import 'package:send_me/constants/_constant.dart';

class WaitDialog extends StatelessWidget {
  const WaitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding: const EdgeInsets.only(
              left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
          children: [
            Column(
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                verticalSpace(5),
                const Text("Please wait...",
                    style: TextStyle(
                        fontFamily: "Carmen Sans",
                        fontSize: 18.0,
                        color: Color(0xFF00053A)))
              ],
            )
          ],
        ));
  }
}
