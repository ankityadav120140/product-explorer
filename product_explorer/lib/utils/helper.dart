import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'errors/exception.dart';

enum RequestType { get, post, delete }

enum LoggerType { d, e, i, f, t, w }

class Helpers {
  static logger({required LoggerType type, required String message}) {
    var logger = Logger(
        printer: PrettyPrinter(
      methodCount: 5,
      errorMethodCount: 8,
      lineLength: 5000,
      colors: true,
      printEmojis: true,
      printTime: false,
    ));

    switch (type) {
      case LoggerType.d:
        logger.d(message);
        break;
      case LoggerType.e:
        logger.e(message);
        break;
      case LoggerType.i:
        logger.i(message);
        break;
      case LoggerType.f:
        logger.f(message);
        break;
      case LoggerType.t:
        logger.t(message);
        break;
      case LoggerType.w:
        logger.w(message);
        break;
    }
  }

  static Future<Map<String, dynamic>?> sendRequest(
      Dio dio, RequestType type, String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers,
      bool encoded = false,
      dynamic data,
      dynamic listData,
      FormData? formData}) async {
    try {
      var logger = Logger(
        printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 50,
            colors: true,
            printEmojis: true,
            printTime: false),
      );
      logger
          .d("PayLoad ${queryParams ?? data ?? listData ?? formData?.fields}");
      Response response;

      switch (type) {
        case RequestType.get:
          response = (await dio.get(path,
              queryParameters: queryParams,
              options: Options(headers: headers)));
          break;
        case RequestType.post:
          response = (await dio.post(path,
              options: Options(
                  headers: headers,
                  contentType: encoded == true
                      ? Headers.formUrlEncodedContentType
                      : null,
                  validateStatus: (code) => true),
              data: queryParams ??
                  listData ??
                  formData ??
                  FormData.fromMap(data), onSendProgress: ((count, total) {
            log('Sending Count $count');
            log('Sending Total $total');
          }), onReceiveProgress: ((count, total) {
            log('Receiving Count $count');
            log('Receiving Total $total');
          })));
          break;
        case RequestType.delete:
          response = (await dio.delete(path,
              queryParameters: queryParams,
              options: Options(headers: headers)));
          break;
        default:
          return null;
      }
      logger.d(
          "$path response status code ${response.statusCode} message is ${response.statusMessage}");
      if (response.statusCode == 200) {
        logger.i("Success data ${response.data}");
        return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 400 || response.statusCode == 202) {
        throw ServerException(
            code: response.statusCode, message: response.statusMessage);
      } else {
        debugPrint("I go here 1");
        debugPrint("statuscode${response.statusCode.toString()}");
        debugPrint(response.statusMessage.toString());
        debugPrint(response.data.toString());
        throw ServerException(
            message:
                response.data['message'] ?? response.data['errors']['message'],
            code: response.statusCode);
      }
    } on ServerException catch (e) {
      debugPrint("I go here 2");
      throw ServerException(message: e.message, code: e.code);
    } on DioException catch (e) {
      debugPrint("Dio Exception${e.response?.data}");
      if (e.error == "Http status error [401]") {
        debugPrint("I go here 3 ${e.error == "Http status error [401]"}");
      } else {
        throw ServerException(
            message: e.error is SocketException
                ? "No Internet"
                : e.response?.data['message'].toString());
      }
    }
    return null;
  }

  static String getFormattedDateMonth({required DateTime date}) {
    return DateFormat('d MMM y', 'en_US').format(date);
  }

  static String getFormattedTime({required DateTime date}) {
    return DateFormat("hh:mm a").format(date);
  }

  Future<void> setString({
    required String key,
    required String value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString({
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    return value;
  }
}
