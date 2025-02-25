import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';
import 'package:webuywesell/app/core/widgets/base.dart';
import 'package:webuywesell/app/modules/home/controllers/footer.dart';
import 'package:webuywesell/app/modules/support_center/pages/content.dart';

import '../controllers/others_controller.dart';

class OthersView extends GetView<OthersController> {
  const OthersView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(screens: [
      SupportSection(),
      SizedBox(height: 50),
      MobileFooterPageView(),
    ]);
  }
}
