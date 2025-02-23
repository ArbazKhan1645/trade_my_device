import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_screen_controller.dart';
import '../widgets/profile.dart';

class ProfileScreenView extends GetView<ProfileScreenController> {
  const ProfileScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileScreenController>(
        init: ProfileScreenController(),
        builder: (controller) {
          return OrderScreen();
        });
  }
}
