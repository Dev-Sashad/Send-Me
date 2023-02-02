import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

class YesNoCancelDialog extends StatelessWidget {
  final Widget message;
  final VoidCallback route;
  YesNoCancelDialog(this.message, this.route, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: const EdgeInsets.only(top: 20.0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                  child: message),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10)),
                      highlightColor: AppColors.primaryColor,
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey.shade300),
                              right: BorderSide(color: Colors.grey.shade300)),
                        ),
                        alignment: Alignment.center,
                        child: const CustomText(
                          "No",
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10)),
                      highlightColor: AppColors.primaryColor,
                      onTap: () => route(),
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        )),
                        alignment: Alignment.center,
                        child: const CustomText(
                          "Yes",
                        ),
                      ),
                    ))
              ],
            )
          ],
        )
      ],
    );
  }
}
