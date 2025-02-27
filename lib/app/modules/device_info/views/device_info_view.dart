// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/device_info_controller.dart';
import '../widgets/device_info_body.dart';

class DeviceInfoView extends GetView<DeviceInfoController> {
  const DeviceInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return DeviceInfoBodyScreen();
  }
}
