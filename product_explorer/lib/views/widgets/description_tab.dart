import 'package:flutter/material.dart';
import 'package:product_explorer/views/widgets/label_card.dart';
import 'package:sizer/sizer.dart';

import '../../models/responses/get_products_response.dart';

class DescriptionTab extends StatelessWidget {
  final Product product;

  const DescriptionTab({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: labelCard(
        label: "Description",
        value: product.description,
      ),
    );
  }
}
