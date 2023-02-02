import 'package:flutter/material.dart';

class OkCancelDialog extends StatelessWidget {
  //String message;
  Widget message;
  String firstText;
  String secondText;
  VoidCallback route;
  VoidCallback? cancle;
  OkCancelDialog(this.message, this.route,
      {Key? key,
      this.cancle,
      this.firstText = "Cancel",
      this.secondText = "Ok"})
      : super(key: key);

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
                      top: 10.0, left: 15.0, right: 15.0, bottom: 20.0),
                  child: message),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: const Radius.circular(10)),
                      highlightColor: const Color(0xFF0D1884),
                      onTap: cancle ?? () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey.shade300),
                              right: BorderSide(color: Colors.grey.shade300)),
                        ),
                        alignment: Alignment.center,
                        child: Text(firstText,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                color: Color(0xFF00053A),
                                fontSize: 13.0,
                                fontFamily: "Carmen Sans")),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10)),
                      // splashColor: Color(0xFF0D1884),
                      highlightColor: const Color(0xFF0D1884),
                      onTap: () => route(),
                      child: Container(
                        //margin: EdgeInsets.only(right: 10.0),//()=>route()
                        padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        )),
                        alignment: Alignment.center,
                        child: Text(secondText,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                color: Color(0xFF00053A),
                                fontSize: 13.0,
                                fontFamily: "Carmen Sans")),
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
