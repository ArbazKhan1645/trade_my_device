import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/base.dart';
import '../../home/controllers/footer.dart';
import '../controllers/support_center_controller.dart';
import '../pages/content.dart';

class SupportCenterView extends GetView<SupportCenterController> {
  const SupportCenterView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(screens: [
      SizedBox(height: 40),
      Container(
        decoration: BoxDecoration(color: Colors.white),
        height: 90,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Support Center',
                      style: defaultTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 50),
      SupportSection(),
      SizedBox(height: 50),
      MobileFooterPageView(),
    ]);
  }
}
