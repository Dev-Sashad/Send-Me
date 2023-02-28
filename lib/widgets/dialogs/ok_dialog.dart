import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

class OkDialog extends StatelessWidget {
  final Widget message;
  const OkDialog(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: const EdgeInsets.only(
          left: 20.0, right: 20.0, bottom: 30.0, top: 30.0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: const EdgeInsets.only(top: 10.0), child: message),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 80.0, right: 80.0),
                margin: const EdgeInsets.only(top: 40.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.primaryColor),
                child: const Text("OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: "Carmen Sans")),
              ),
            )
          ],
        )
      ],
    );
  }
}

class NewOkDialog extends StatelessWidget {
  final String? image;
  final String? title;
  final String? message;
  final void Function()? onpressed;
  const NewOkDialog(this.image,
      {Key? key, this.message, this.onpressed, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgImage(imgUrl: image!, height: eqH(140), width: eqH(140)),
            verticalSpace(10),
            CustomText(
              title ?? '',
              textType: TextType.largeText,
              fontWeight: FontWeight.bold,
            ),
            verticalSpace(5),
            RichText(
                text: TextSpan(
                    text: message,
                    style: Theme.of(context).textTheme.bodyMedium)),
            verticalSpace(10),
            InkWell(
              onTap: onpressed ?? () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 50.0, right: 50.0),
                margin: const EdgeInsets.only(top: 40.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary),
                child: const Text("Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: "Carmen Sans")),
              ),
            )
          ],
        )
      ],
    );
  }
}
