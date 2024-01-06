import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:product_explorer/views/pages/home_page.dart';
import 'services/database_helper.dart';
import 'package:sizer/sizer.dart';

import 'utils/dependency_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjector.initializeControllers();
  await DatabaseHelper.instance.fetchDatabase;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Product Explorer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
        builder: EasyLoading.init(),
      );
    });
  }
}
