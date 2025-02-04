// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/routes/app_pages.dart';

class DeviceInfoMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check if arguments exist
    final args = Get.arguments;

    // If arguments are null or don't contain required data, redirect
    if (args == null) {
      // You can replace '/home' with your desired fallback route
      return RouteSettings(name: Routes.SELL_MY_PHONE);
    }

    // If arguments exist, allow navigation to proceed
    return null;
  }
}
