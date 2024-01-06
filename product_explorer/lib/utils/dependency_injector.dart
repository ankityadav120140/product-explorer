import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:product_explorer/consts/end_points.dart';
import 'package:product_explorer/contollers/connectivity/connectivity_mixin.dart';
import 'package:product_explorer/contollers/product_controller.dart';

class DependencyInjector {
  static void initializeControllers() {
    Get.put(ConnectivityMixin);
    EasyLoading.init();
    final dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
    Get.lazyPut<Dio>(() => dio);
    Get.put(ProductController(dio: dio));
  }
}
