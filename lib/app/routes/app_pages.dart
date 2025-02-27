// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../modules/about_us/bindings/about_us_binding.dart';
import '../modules/about_us/views/about_us_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/view/authentication_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/device_info/bindings/device_info_binding.dart';
import '../modules/device_info/widgets/basket_view.dart';
import '../modules/device_info/views/device_info_view.dart';
import '../modules/home/view/home_screen_view.dart';
import '../modules/how_its_work/bindings/how_its_work_binding.dart';
import '../modules/how_its_work/views/how_its_work_view.dart';
import '../modules/others/bindings/others_binding.dart';
import '../modules/others/views/others_view.dart';
import '../modules/profile_screen/bindings/profile_screen_binding.dart';
import '../modules/profile_screen/views/profile_screen_view.dart';
import '../modules/sell_my_phone/bindings/sell_my_phone_binding.dart';
import '../models/sell_my_phones_model/mobile_phones_model.dart';
import '../modules/sell_my_phone/views/sell_my_phone_view.dart';
import '../modules/support_center/bindings/support_center_binding.dart';
import '../modules/support_center/views/support_center_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
      arguments: MobilePhonesModel(),
    ),
    GetPage(
      name: _Paths.Payment,
      page: () => const BasketScreen(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticatedAnimatedDialog(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => const ProfileScreenView(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOW_ITS_WORK,
      page: () => const HowItsWorkView(),
      binding: HowItsWorkBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT_CENTER,
      page: () => const SupportCenterView(),
      binding: SupportCenterBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.OTHERS,
      page: () => const OthersView(),
      binding: OthersBinding(),
    ),
  ];
}
