import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

final test = true.obs;
final selectedIndex = 0.obs;
Widget imageCard({
  required String imageUrl,
  required int index,
}) {
  return Obx(() {
    if (test.isTrue) {}
    return InkWell(
      onTap: () {
        selectedIndex.value = index;
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              height: double.infinity,
              width: 35.0.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: selectedIndex.value == index ? 2.sp : 0.0,
                  ),
                  borderRadius: BorderRadius.circular(10.sp)),
              margin: EdgeInsets.all(2.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          if (selectedIndex.value == index)
            Positioned(
              right: 3.w,
              top: 3.w,
              child: const Icon(
                Icons.check_box,
                color: Colors.blue,
              ),
            )
        ],
      ),
    );
  });
}
