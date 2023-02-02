import 'package:flutter/material.dart';
import '../../_lib.dart';

class WaitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding:
              EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
          children: [
            Container(
              child: Row(
                children: [
                  Image.asset(AppGif.gifLoader, width: 70.0, height: 70.0),
                  Text("Please wait...",
                      style: TextStyle(
                          fontFamily: "Carmen Sans",
                          fontSize: 18.0,
                          color: Color(0xFF00053A)))
                ],
              ),
            )
          ],
        ));
  }
}
