// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../home/controllers/footer.dart';
import '../pages/phones_area.dart';

class SellMyPhoneController extends GetxController {
  List<Widget> getDashboardViewBodyScreen = [
    const SizedBox(height: 40),
    SellMyIPhoneScreen(),
    MobileFooterPageView(),
  ];
}
