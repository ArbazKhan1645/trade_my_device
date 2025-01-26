import 'package:get/get.dart';
import 'package:webuywesell/app/services/app/app_service.dart';
import 'package:webuywesell/app/services/auth/auth_service.dart';
import 'package:webuywesell/app/services/others/mobiles_service.dart';

Future<void> initDependencies() async {
  await _initAppService();
  await _initSetupServices();
}

Future<void> _initAppService() async {
  await Get.putAsync(() => AppService().init());
  await Get.putAsync(() => AuthService().init());
}

Future<void> _initSetupServices() async {
  await Get.putAsync(() => MobilePhonesService().init());
}
