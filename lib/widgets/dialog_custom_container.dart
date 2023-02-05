import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_me/_lib.dart';

class DialogCustomContainer extends StatelessWidget {
  final Widget? child;
  const DialogCustomContainer({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: eqH(700),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r)),
            color: Colors.white),
        child: child,
      ),
    );
  }
}
