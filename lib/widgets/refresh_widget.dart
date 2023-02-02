import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

class RefreshWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final String? imgUrl;
  RefreshWidget({this.onPressed, this.text, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(20),
            imgUrl != null
                ? AssetsImage(imgUrl: imgUrl!, height: 100, width: 100)
                : const Icon(
                    Icons.wifi_off_sharp,
                    size: 50.0,
                    color: Colors.black26,
                  ),
            Container(
              child: Text(
                text ?? "Oops, something went wrong. Try again!!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
            verticalSpace(20),
            CustomButton(width: eqW(250), text: "Refresh", onPressed: onPressed)
          ],
        ));
  }
}
