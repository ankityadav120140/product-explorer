import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget labelCard({
  required String label,
  required String value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Get.textTheme.labelLarge?.copyWith(
          color: Colors.blue,
        ),
      ),
      SizedBox(height: 1.h),
      SizedBox(
        width: 40.w,
        child: Text(value == '' ? 'N/A' : value),
      ),
      SizedBox(height: 2.h),
    ],
  );
}
