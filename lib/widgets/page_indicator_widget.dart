import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

Widget pageIndicator(bool isCurrentPage, int index, {void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 4.0,
      width: isCurrentPage ? 12.0 : 4.0,
      decoration: BoxDecoration(
        color: isCurrentPage
            ? AppColors.primaryColor
            : AppColors.teal.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}
