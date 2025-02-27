// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/core/widgets/base.dart';
import '../controllers/checkout_controller.dart';
import '../pages/checkout_body.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(screens: [CheckOutBodyScreen()]);
  }
}
