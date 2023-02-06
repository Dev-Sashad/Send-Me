import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/booking_model.dart';
import 'package:send_me/ui/dashboard/widget/custom_order_details_widget.dart';

class ViewMoreInfo extends StatelessWidget {
  final BookingModel data;
  final VoidCallback onDelete;
  const ViewMoreInfo({Key? key, required this.data, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        useRowAppBar: false,
        showLeading: false,
        title: "Order Details",
        child: CustomScrollWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                verticalSpace(20),
                CustomOrderDetails(
                  title: "Pick-Up",
                  subTitle: data.pickUp,
                ),
                CustomOrderDetails(
                  title: "Drop-Off",
                  subTitle: data.dropOff,
                ),
                CustomOrderDetails(
                  title: "Reciever's No",
                  subTitle: data.recieverNo,
                ),
                CustomOrderDetails(
                  title: "Order-date",
                  subTitle: formatDate(data.bookingDate),
                ),
                CustomOrderDetails(
                  title: "Delivery Status",
                  subTitle: data.deliveryStatus,
                  subtitleColor: data.deliveryStatus == 'pending'
                      ? Colors.orange[400]
                      : data.deliveryStatus == 'completed'
                          ? AppColors.green
                          : Colors.redAccent[400],
                ),
                CustomOrderDetails(
                  title: "Weight",
                  subTitle: "${data.weight} Kg",
                ),
                CustomOrderDetails(
                  title: "Distance",
                  subTitle: "${data.distance} Km",
                ),
                CustomOrderDetails(
                  title: "Order ID",
                  subTitle: data.referenceId,
                ),
                CustomOrderDetails(
                  title: "Fee",
                  subTitle:
                      currencyFormater(data.fee.toString(), symbol: "USD "),
                  subtitleColor: AppColors.appBlue,
                ),
                verticalSpace(20),
                CustomButton(
                  text: "Delete",
                  onPressed: onDelete,
                ),
                verticalSpace(20)
              ],
            ),
          ),
        ));
  }
}