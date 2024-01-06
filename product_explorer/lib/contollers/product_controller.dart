import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:product_explorer/local/controller/local_product_controller.dart';
import 'package:product_explorer/models/responses/get_products_response.dart';
import 'package:product_explorer/services/product_services.dart';

class ProductController extends GetxController {
  final Dio dio;
  ProductController({required this.dio});
  final products = <Product>[].obs;
  late final _service = ProductServices(dio: dio);

  Future<bool> downloadProducts() async {
    EasyLoading.show();
    final successOrFailure = await _service.getAllProducts();
    successOrFailure.fold((l) {
      EasyLoading.dismiss();
      EasyLoading.showError(l.toString());
      debugPrint("Failure In endRide $l");
    }, (r) async {
      await LocalProductController().deleteLocalProduct();
      await LocalProductController().insertLocalProduct(r.products);
      await getAllProducts();
    });
    return successOrFailure.isRight();
  }

  Future<bool> getAllProducts() async {
    final offlineProducts =
        await LocalProductController().fetchAllLocalProducts();
    products.value = offlineProducts;
    products.refresh();
    EasyLoading.dismiss();
    return products.isNotEmpty;
  }
}
