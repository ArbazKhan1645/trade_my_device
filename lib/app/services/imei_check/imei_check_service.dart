// ignore_for_file: unused_element, unused_field

import 'dart:async';
import 'package:get/get.dart';
import 'package:webuywesell/app/repo/network_repository.dart';
import 'package:webuywesell/app/services/auth/auth_service.dart';
import '../../data/configs/api_configs.dart';
import '../../models/phones_model/imei_model.dart';
import '../app/app_service.dart';

class ImeiCheckservice extends GetxService {
  final repository = NetworkRepository();
  late final AppService _appService;
  late final AuthService _authService;

  Future<ImeiCheckservice> init() async {
    await _init();
    return this;
  }

  Future<void> _init() async {
    _appService = Get.find<AppService>();
    _authService = Get.find<AuthService>();
  }

  Future<ImeiCheckResponse?> checkImeiBasic(String imei) async {
    try {
      final response = await repository.fetchData<ImeiCheckResponse>(
          url:
              '${ApiConfig.baseUrl}${ApiConfig.basixServiceImeiId}/?API_KEY=${ApiConfig.api_key}&imei=$imei',
          fromJson: (json) => ImeiCheckResponse.fromJson(json));
      return response;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
