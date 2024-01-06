import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ConnectivityMixin on GetxController {
  final RxBool _isOnline = true.obs;

  bool get isOnline => _isOnline.value;

  @override
  void onInit() {
    super.onInit();
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _handleOffline();
      } else {
        _handleOnline();
      }
    });
  }

  void _handleOnline() {
    if (!_isOnline.value) {
      _isOnline.value = true;
      onConnectivityChanged(true);
    }
  }

  void _handleOffline() {
    if (_isOnline.value) {
      _isOnline.value = false;
      onConnectivityChanged(false);
    }
  }

  void onConnectivityChanged(bool isOnline) {
    debugPrint('Connectivity changed: $isOnline');
  }
}
