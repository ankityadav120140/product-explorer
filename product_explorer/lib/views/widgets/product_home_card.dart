import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_explorer/views/pages/product_details_page.dart';
import 'package:sizer/sizer.dart';

import '../../models/responses/get_products_response.dart';

Widget productHomeCard({required Product product}) {
  return InkWell(
    onTap: () {
      Get.to(ProductDetailsPage(product: product));
    },
    child: Container(
      padding: EdgeInsets.all(2.w),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.qrCode,
            style: Get.textTheme.titleSmall
                ?.copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(
                width: 20.w,
                child: Image.network(product.imageUrl),
              ),
              SizedBox(width: 4.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 60.w,
                      child: Text('OP:${product.option}, MAX:${product.mrp}')),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      product.color,
                      style: Get.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      const Text('Sizes : '),
                      SizedBox(
                        width: 45.w,
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(product.availableSizes.length,
                              (index) {
                            return Text(
                              "${product.availableSizes[index]}, ",
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: Colors.blue,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
