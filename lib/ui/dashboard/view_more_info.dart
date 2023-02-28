import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/booking_model.dart';
import 'package:send_me/ui/dashboard/widget/custom_order_details_widget.dart';
import 'notifier/dashboard_vm.dart';

class ViewMoreInfo extends ConsumerWidget {
  final BookingModel data;
  final String docsId;
  const ViewMoreInfo({Key? key, required this.data, required this.docsId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return DialogCustomContainer(
      child: BaseScaffold(
          backgroundColor: Colors.transparent,
          useRowAppBar: false,
          showLeading: false,
          showSubTitle: false,
          onPop: () => Navigator.of(context).pop(),
          title: "Order Details",
          child: CustomScrollWidget(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    subTitle: data.deliveryStatus!.capitalize(),
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
                    subTitleFontsize: 25.sp,
                    subtitleColor: AppColors.appBlue,
                  ),
                  verticalSpace(20),
                  Visibility(
                    visible: data.deliveryStatus!.toLowerCase() != "completed",
                    child: CustomButton(
                      text: "Received",
                      onPressed: () async {
                        ref.read(dashboardVm).completeOrder(
                            id: docsId, call: () => Navigator.pop(context));
                      },
                    ),
                  ),
                  Visibility(
                    visible: data.deliveryStatus!.toLowerCase() != "completed",
                    child: TextButton(
                      child: CustomText(
                        "Cancel",
                        textType: TextType.mediumText,
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        ref.read(dashboardVm).deleteOrder(
                            id: docsId, call: () => Navigator.pop(context));
                      },
                    ),
                  ),
                  verticalSpace(20)
                ],
              ),
            ),
          )),
    );
  }
}
