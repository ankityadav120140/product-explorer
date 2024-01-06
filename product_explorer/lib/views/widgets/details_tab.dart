import 'package:flutter/material.dart';
import 'package:product_explorer/views/widgets/label_card.dart';
import 'package:sizer/sizer.dart';

import '../../models/responses/get_products_response.dart';

class DetailsTab extends StatelessWidget {
  final Product product;
  const DetailsTab({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelCard(
                label: 'Brand',
                value: product.brand,
              ),
              labelCard(
                label: 'Collection',
                value: product.collection,
              ),
              labelCard(
                label: 'Fit',
                value: product.fit,
              ),
              labelCard(
                label: 'Finish',
                value: product.finish,
              ),
              labelCard(
                label: 'Gender',
                value: product.gender,
              ),
            ],
          ),
          Column(
            children: [
              labelCard(
                label: 'Category',
                value: product.category,
              ),
              labelCard(
                label: 'Sub-Catergory',
                value: product.subCategory,
              ),
              labelCard(
                label: 'Theme',
                value: product.theme,
              ),
              labelCard(
                label: 'Offer Month',
                value: product.offerMonths,
              ),
              labelCard(
                label: 'Name',
                value: product.name,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
