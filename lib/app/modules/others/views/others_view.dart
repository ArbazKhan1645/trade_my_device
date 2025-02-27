// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:trademydevice/app/core/widgets/base.dart';
import 'package:trademydevice/app/modules/home/widgets/footer_widget.dart';
import 'package:trademydevice/app/modules/others/pages/others_content_body.dart';

import '../controllers/others_controller.dart';

class OthersView extends GetView<OthersController> {
  const OthersView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(screens: [
      OtherSectionBody(),
      SizedBox(height: 50),
      FooterPageViewWidget(),
    ]);
  }
}
