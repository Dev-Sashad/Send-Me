import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

class NoHistoryWidget extends StatelessWidget {
  final String? text;
  final String? imgUrl;
  const NoHistoryWidget({Key? key, this.text, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgUrl != null
                ? AssetsImage(imgUrl: imgUrl!, height: 100, width: 100)
                : const Icon(
                    Icons.hourglass_empty_outlined,
                    size: 50.0,
                    color: Colors.black26,
                  ),
            Text(
              text ?? "You have no request history",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black38,
              ),
            ),
            verticalSpace(20),
          ],
        ));
  }
}
