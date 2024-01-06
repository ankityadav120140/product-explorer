import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_explorer/consts/keys.dart';
import 'package:product_explorer/contollers/product_controller.dart';
import 'package:product_explorer/local/controller/local_product_controller.dart';
import 'package:product_explorer/utils/helper.dart';
import 'package:product_explorer/views/pages/all_products_page.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final lastSync = ''.obs;
  final downloading = false.obs;
  final ProductController productController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkDownload();
    });
  }

  Future checkDownload() async {
    lastSync.value = await Helpers().getString(key: Keys.LASTSYNC) ?? '';
    if (lastSync.isEmpty) {
      await _downloadData();
    }
  }

  Future<void> _downloadData() async {
    progress.value = 0.0;
    downloading.value = true;
    await productController.downloadProducts();
    lastSync.value = DateTime.now().toString();
    downloading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Explorer'),
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: Obx(() {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome!",
                style: Get.textTheme.displayMedium,
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 50.w,
                child: Image.asset('assets/pe_logo.jpg'),
              ),
              SizedBox(height: 10.h),
              ElevatedButton.icon(
                onPressed: downloading.value ? null : _downloadData,
                icon: const Icon(Icons.download),
                label: Text(lastSync.isNotEmpty
                    ? 'Re-Sync'
                    : downloading.value
                        ? 'Downloading...'
                        : 'Download'),
              ),
              SizedBox(height: 5.h),
              if (downloading.value) ...{
                LinearProgressIndicator(value: progress.value / 100),
                SizedBox(height: 2.h),
                Text(
                  'Progress: ${progress.value.toStringAsFixed(1)}%',
                  style: Get.textTheme.bodyMedium,
                ),
              } else if (lastSync.isNotEmpty) ...{
                Text(
                  "Last Sync: ${Helpers.getFormattedDateMonth(date: DateTime.parse(lastSync.value))}, ${Helpers.getFormattedTime(date: DateTime.parse(lastSync.value))}",
                  style: Get.textTheme.bodyMedium,
                ),
                SizedBox(height: 2.h),
              },
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (lastSync.isNotEmpty) {
            Get.to(const AllProductsPage());
          }
        },
        label: const Row(
          children: [
            Text('Explore Products'),
            Icon(Icons.arrow_right_alt),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
