// ignore_for_file: unused_element, unused_field

import 'dart:async';
import 'package:get/get.dart';
import 'package:webuywesell/app/services/auth/auth_service.dart';
import '../app/app_service.dart';

class MobilePhonesService extends GetxService {
  late final AppService _appService;
  late final AuthService _authService;

  Future<MobilePhonesService> init() async {
    await _init();
    return this;
  }

  Future<void> _init() async {
    _appService = Get.find<AppService>();
    _authService = Get.find<AuthService>();
  }

  @override
  void onReady() {
    // watchAllLocationFromSupabase();
  }

  @override
  void onClose() {}
}
