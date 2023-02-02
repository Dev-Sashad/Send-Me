import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../_lib.dart';

// ignore: must_be_immutable
class SearchBottomSheet extends StatefulWidget {
  final List<String>? data;
  String title;
  SearchBottomSheet({Key? key, @required this.data, this.title = ""})
      : super(key: key);
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  List<String> data = [];
  @override
  void initState() {
    data = widget.data ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: screenHeight * 0.4,
            padding:
                EdgeInsets.only(left: eqW(20), right: eqW(20), top: eqH(20)),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r))),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Card(
                    elevation: 1,
                    child: Container(
                      height: 5,
                      width: eqW(56),
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(16.r)),
                    ),
                  ),
                ),
                verticalSpace(eqH(19)),
                CustomText(widget.title,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    textType: TextType.mediumText),
                verticalSpace(eqH(40)),
                Expanded(
                    child: ScrollConfiguration(
                  behavior: const MaterialScrollBehavior()
                      .copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...data
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop<String>(e);
                                  },
                                  child: _child(e),
                                ),
                              )
                              .toList(),
                          verticalSpace(eqH(20))
                        ]),
                  ),
                )),
              ],
            )),
      ),
    );
  }

  Widget _child(String text) {
    return Column(
      children: [
        // verticalSpace(eqH(10)),
        CustomText(
          text,
          fontSize: 16.sp,
        ),
        verticalSpace(eqH(10)),
        const Divider(
          thickness: 1.0,
          height: 1,
          color: AppColors.grey,
        ),
        verticalSpace(eqH(20)),
      ],
    );
  }
}
