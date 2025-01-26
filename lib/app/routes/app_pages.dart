import 'package:get/get.dart';

import '../modules/device_info/bindings/device_info_binding.dart';
import '../modules/device_info/views/device_info_view.dart';
import '../modules/home/home.screen.dart';
import '../modules/sell_my_phone/bindings/sell_my_phone_binding.dart';
import '../modules/sell_my_phone/views/sell_my_phone_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SELL_MY_PHONE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SELL_MY_PHONE,
      page: () => const SellMyPhoneView(),
      binding: SellMyPhoneBinding(),
    ),
    GetPage(
      name: _Paths.DEVICE_INFO,
      page: () => const DeviceInfoView(),
      binding: DeviceInfoBinding(),
    ),
  ];
}
