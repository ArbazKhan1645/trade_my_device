// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:webuywesell/app/models/users_model.dart/customer_models.dart';
import 'package:webuywesell/app/services/auth/auth_service.dart';
import '../../../../main.dart';
import '../../../models/phones_model/imei_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/footer.dart';
import '../../sell_my_phone/models/mobile_phones_model.dart';
import '../pages/section.dart';

class DeviceInfoController extends GetxController {
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;
  MobilePhonesModel? phonecurrent = MobilePhonesModel();
  final TextEditingController emailController = TextEditingController();

  ImeiCheckResponse? currentdevice;

  bool get isloginAuthService {
    return AuthService.instance.islogin;
  }

  void setErrorMessage(String message) {
    errorMessage.value = message;
  }

  void setisLoading(bool val) {
    isLoading.value = val;
  }

  final formKey = GlobalKey<FormState>();

  String get email => emailController.text.trim();
  bool get loading => isLoading.value;

  Future<void> handleAccountCreation() async {
    try {
      if (isloginAuthService) {
        Get.offNamed(Routes.Payment);
        return;
      }
      setisLoading(true);
      final value = await supbaseClient.auth.signUp(
        email: email,
        password: 'password',
      );
      if (value.user == null) {
        setErrorMessage('Something went wrong, please try again');
        return;
      }
      final insertResponse = await supbaseClient.from('users').insert({
        'email': email,
      }).select();
      if (insertResponse.isEmpty) {
        setErrorMessage('Failed to create user, please try again');
        return;
      }
      final customerJson = insertResponse[0];
      CustomerModel customer = CustomerModel.fromJson(customerJson);
      AuthService.instance.saveAuthState(customer);
      Get.offNamed(Routes.Payment);
    } catch (e) {
      setErrorMessage('Error: ${e.toString()}');
    } finally {
      setisLoading(false);
      update();
    }
  }

  List<Widget> getDashboardViewBodyScreen = [
    const SizedBox(height: 40),
    DeviceInfoScreen(),
    const SizedBox(height: 40),
    MobileFooterPageView(),
  ];

  @override
  void onInit() {
    phonecurrent = Get.arguments;
    super.onInit();
  }
}
