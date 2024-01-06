import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_explorer/models/responses/get_products_response.dart';
import 'package:sizer/sizer.dart';

import '../widgets/description_tab.dart';
import '../widgets/details_tab.dart';
import '../widgets/img_card.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  final test = true.obs;
  final selectedTabIndex = 0.obs;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    selectedIndex.value = 0;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Obx(() {
            if (test.isTrue) {}
            return SingleChildScrollView(
              child: Column(
                children: [
                  instructionCard(),
                  SizedBox(height: 1.h),
                  imageRow(),
                  aboutProductCard(),
                  SizedBox(height: 1.h),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Details'),
                      Tab(text: 'Description'),
                    ],
                    onTap: (index) {
                      selectedTabIndex.value = index;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        DetailsTab(product: widget.product),
                        DescriptionTab(product: widget.product),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 44.w,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Category width',
                                style: Get.textTheme.labelLarge?.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              const Text('1/XXX'),
                              SizedBox(height: 2.h),
                            ],
                          )),
                      Container(
                          width: 44.w,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Catergory total',
                                style: Get.textTheme.labelLarge?.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              const Text('XXXXX'),
                              SizedBox(height: 2.h),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 2.h)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget instructionCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('5 Options( Tap to Select)'),
        RichText(
          text: TextSpan(
            text: 'Total Qty : ',
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: widget.product.maxQuantity.toString(),
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget imageRow() {
    return SizedBox(
      height: 20.h,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String imageUrl = getImageUrl(index);
          return imageCard(
            imageUrl: imageUrl,
            index: index,
          );
        },
      ),
    );
  }

  String getImageUrl(int index) {
    switch (index) {
      case 0:
        return widget.product.technologyImageUrl ?? widget.product.imageUrl;
      case 1:
        return widget.product.imageUrl2;
      case 2:
        return widget.product.imageUrl3;
      case 3:
        return widget.product.imageUrl4;
      case 4:
        return widget.product.imageUrl5;
      default:
        return widget.product.imageUrl;
    }
  }

  Widget aboutProductCard() {
    return Container(
      padding: EdgeInsets.all(2.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'OP:${widget.product.option}, MAX:${widget.product.mrp}'),
                  Text(
                    widget.product.color,
                    style: Get.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                '\$${widget.product.mrp}',
                style: Get.textTheme.bodyLarge?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
