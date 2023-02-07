import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/booking_model.dart';

class CustomOrderTile extends StatelessWidget {
  final BookingModel data;
  final int index;
  final int listLength;
  final void Function()? onTap;
  const CustomOrderTile(
      {Key? key,
      required this.data,
      required this.index,
      required this.listLength,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Color? deliveryC;
    if (data.deliveryStatus == 'pending') {
      deliveryC = Colors.orange[400];
    } else if (data.deliveryStatus == 'completed') {
      deliveryC = AppColors.green;
    } else {
      deliveryC = Colors.redAccent[400];
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            top: index == 0 ? 5 : 15,
            left: 5,
            right: 5,
            bottom: index == listLength - 1 ? 50 : 0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CustomText(
                  'Fee - ',
                ),
                CustomText(
                  currencyFormater(data.fee.toString(), symbol: "USD "),
                  color: AppColors.appBlue,
                  textType: TextType.largeText,
                ),
              ],
            ),
            verticalSpace(7),
            SizedBox(
              //width: eqW(300),
              child: CustomText(
                'Pick-Up - ${data.pickUp}',
              ),
            ),
            verticalSpace(7),
            SizedBox(
              // width: eqW(300),
              child: CustomText(
                'Drop-Off - ${data.dropOff}',
              ),
            ),
            verticalSpace(7),
            SizedBox(
              width: eqW(250),
              child: CustomText(
                'Reciever\'s No - ${data.recieverNo}',
              ),
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'order date - ${formatDate(data.bookingDate)}',
                  style: const TextStyle(color: AppColors.black),
                ),
                Row(
                  children: [
                    const CustomText(
                      'status - ',
                    ),
                    CustomText(
                      data.deliveryStatus!.capitalize(),
                      color: deliveryC,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
