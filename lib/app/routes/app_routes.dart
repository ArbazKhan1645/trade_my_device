// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SELL_MY_PHONE = _Paths.SELL_MY_PHONE;
  static const DEVICE_INFO = _Paths.DEVICE_INFO;
  static const Payment = _Paths.Payment;
  static const CHECKOUT = _Paths.CHECKOUT;
  static const AUTHENTICATION = _Paths.AUTHENTICATION;
  static const PROFILE_SCREEN = _Paths.PROFILE_SCREEN;
  static const HOW_ITS_WORK = _Paths.HOW_ITS_WORK;
  static const SUPPORT_CENTER = _Paths.SUPPORT_CENTER;
  static const ABOUT_US = _Paths.ABOUT_US;
  static const OTHERS = _Paths.OTHERS;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const Payment = '/Payment';
  static const SELL_MY_PHONE = '/sell-my-phone';
  static const DEVICE_INFO = '/device-info';
  static const CHECKOUT = '/checkout';
  static const AUTHENTICATION = '/authentication';
  static const PROFILE_SCREEN = '/profile-screen';
  static const HOW_ITS_WORK = '/how-its-work';
  static const SUPPORT_CENTER = '/support-center';
  static const ABOUT_US = '/about-us';
  static const OTHERS = '/others';
}
