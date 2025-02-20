import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/core/widgets/base.dart';
import '../controllers/checkout_controller.dart';
import '../pages/body.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(screens: [StepFlowScreen()]);
  }
}
