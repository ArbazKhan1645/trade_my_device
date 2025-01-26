import 'package:get/get.dart';

import '../controllers/sell_my_phone_controller.dart';

class SellMyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellMyPhoneController>(
      () => SellMyPhoneController(),
    );
  }
}
