import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../models/responses/get_products_response.dart';
import '../../contollers/product_controller.dart';
import '../widgets/product_home_card.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final ProductController productController = Get.find();
  final searchController = TextEditingController().obs;
  final test = true.obs;
  final filteredProducts = <Product>[].obs;

  Future getData() async {
    await productController.getAllProducts();
    filteredProducts.assignAll(productController.products);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      EasyLoading.show();
      await getData();
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await productController.downloadProducts();
        },
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(5.w),
            child: Obx(() {
              if (test.isTrue) {}
              return Column(
                children: [
                  searchBar(),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return productHomeCard(product: product);
                        }),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return TextField(
      controller: searchController.value,
      style: TextStyle(fontSize: 13.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
        filled: true,
        fillColor: Colors.grey.shade300,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            filteredProducts.assignAll(productController.products);
            searchController.value.clear();
          },
        ),
        hintText: 'Search',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25.sp),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25.sp),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          filterProducts(value);
        } else {
          filteredProducts.assignAll(productController.products);
        }
      },
    );
  }

  void filterProducts(String query) {
    filteredProducts.assignAll(productController.products
        .where((product) =>
            product.qrCode.toLowerCase().contains(query.toLowerCase()) ||
            product.option.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }
}
