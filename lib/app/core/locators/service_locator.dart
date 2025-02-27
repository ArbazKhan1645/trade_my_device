import 'package:get/get.dart';
import 'package:trademydevice/app/services/app/app_service.dart';
import 'package:trademydevice/app/services/auth/auth_service.dart';

Future<void> initDependencies() async {
  await _initAppService();
  await _initSetupServices();
}

Future<void> _initAppService() async {
  await Get.putAsync(() => AppService().init());
  await Get.putAsync(() => AuthService().init());
}

Future<void> _initSetupServices() async {}
