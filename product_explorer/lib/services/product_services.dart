import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:product_explorer/consts/end_points.dart';
import 'package:product_explorer/utils/errors/failures.dart';

import '../models/responses/get_products_response.dart';
import '../utils/errors/exception.dart';
import '../utils/helper.dart';

class ProductServices {
  final Dio dio;
  ProductServices({required this.dio});

  Future<Either<Failure, GetProductsWithSizesResponse>> getAllProducts() async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.get,
        EndPoints.allProducts,
        queryParams: {
          "retailerCode": 40984,
        },
      );
      return Right(GetProductsWithSizesResponse.fromJson(response!));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
