// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sell_my_phone_controller.dart';
import '../pages/sell_my_phone_body.dart';

class SellMyPhoneView extends GetView<SellMyPhoneController> {
  const SellMyPhoneView({super.key});
  @override
  Widget build(BuildContext context) {
    return SellMyPhoneBodyScreen();
  }
}
