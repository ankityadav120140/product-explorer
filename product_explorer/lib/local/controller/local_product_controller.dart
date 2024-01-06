import 'package:get/get.dart';
import 'package:product_explorer/models/responses/get_products_response.dart';
import 'package:sqflite/sqflite.dart';
import '../../services/database_helper.dart';
import '../../utils/helper.dart';

final progress = 0.0.obs;

class LocalProductController {
  final Database? _database = DatabaseHelper.database;

  Future<void> insertLocalProduct(List<Product> localProductData) async {
    try {
      final totalProducts = localProductData.length;
      var completedProducts = 0;
      for (final singleLocalProductData in localProductData) {
        final productDataWithoutSizes =
            Map<String, dynamic>.from(singleLocalProductData.toJson());
        productDataWithoutSizes.remove('AvailableSizes');
        final productId =
            await _database?.insert('products', productDataWithoutSizes);

        final availableSizes = singleLocalProductData.availableSizes;
        for (final size in availableSizes) {
          await _database?.insert(
              'AvailableSizes', {'product_id': productId, 'size': size});
        }
        completedProducts++;
        progress.value = (completedProducts / totalProducts) * 100;
      }
    } catch (error) {
      Helpers.logger(
          type: LoggerType.w, message: "Insert localProductList $error");
    }
  }

  Future<List<Product>> fetchAllLocalProducts() async {
    try {
      final List<Map<String, dynamic>> productData =
          await _database!.query('products');

      final List<Map<String, dynamic>> modifiedProductData = [];

      for (final product in productData) {
        final List<Map<String, dynamic>> sizesData = await _database!.query(
          'AvailableSizes',
          where: 'product_id = ?',
          whereArgs: [product['id']],
        );
        final List<String> sizes =
            sizesData.map((e) => e['size'].toString()).toList();
        final Map<String, dynamic> modifiedProduct = {
          ...product,
          'AvailableSizes': sizes
        };
        modifiedProductData.add(modifiedProduct);
      }
      final List<Product> localProducts = modifiedProductData.map((e) {
        Product thisProduct = Product.fromJson(e);
        return thisProduct;
      }).toList();

      return localProducts;
    } catch (error) {
      Helpers.logger(
        type: LoggerType.w,
        message: "Fetch all localProducts with AvailableSizes $error",
      );
      return [];
    }
  }

  Future<void> deleteLocalProduct() async {
    try {
      await _database?.delete('products');
      await _database?.delete('AvailableSizes');
    } catch (error) {
      Helpers.logger(
          type: LoggerType.w, message: "Delete localProductList $error");
    }
  }
}
