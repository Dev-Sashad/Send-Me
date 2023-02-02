import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../_lib.dart';
import '../../widgets/bottom_sheet_widget.dart';

String? isEmpty(value) {
  if (value.isEmpty) {
    return 'Field cannot be empty';
  }
  return null;
}

String capitalize(val) {
  return "${val[0].toUpperCase()}${val.substring(1)}";
}

numberFormat(String amount) {
  return NumberFormat.decimalPattern()
      .format(double.parse(amount.replaceAll(",", "")));
}

formatDate(value) {
  final df = new DateFormat('dd-MM-yyyy');
  return df.format(DateTime.parse(value));
}

formatDateTime(value) {
  final df = new DateFormat('d MMMM, y hh:mm a');
  return df.format(DateTime.parse(value));
}

customTimePicker(
    {Function(DateTime?)? onChanged,
    Function(DateTime?)? onConfirmed,
    DateTime? minTime,
    DateTime? maxTime,
    BuildContext? context}) {
  return DatePicker.showDatePicker(Get.context!,
      showTitleActions: true,
      minTime: minTime ?? DateTime(1900, 1, 1),
      maxTime: maxTime ?? DateTime.now(),
      onChanged: onChanged,
      onConfirm: onConfirmed,
      currentTime: DateTime.now(),
      theme: DatePickerTheme(
          itemStyle: Theme.of(context!).textTheme.bodyLarge!,
          backgroundColor: AppColors.white,
          cancelStyle: Theme.of(context).textTheme.bodyMedium!,
          doneStyle: Theme.of(context).textTheme.bodyMedium!),
      locale: LocaleType.en);
}

showBottomSearch(List<String> data, String title, BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SearchBottomSheet(
          data: data,
          title: title,
        );
      });
}

currencyFormater(String value, {String symbol = "NGN "}) {
  Locale locale = Localizations.localeOf(context);
  return NumberFormat.currency(name: symbol)
      .format(double.parse(value.toString().replaceAll(",", "")));
}
