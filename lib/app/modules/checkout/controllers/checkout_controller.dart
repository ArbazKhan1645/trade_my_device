// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trademydevice/app/data/configs/mailer_api.dart';
import 'package:trademydevice/app/routes/app_pages.dart';
import '../../../../main.dart';
import '../../../models/users_model.dart/customer_models.dart';
import '../../../services/app/app_service.dart';
import '../../../services/auth/auth_service.dart';
import 'package:intl/intl.dart';
import '../../../models/sell_my_phones_model/mobile_phones_model.dart';

class CheckoutController extends GetxController {
  var currentStep = 0.obs;
  final totalSteps = 4;
  CustomerModel? get isloginAuthService => AuthService.instance.authCustomer;

  List<MobilePhonesModel> phonesList = [];
  List<MobilePhonesModel> getPhoneList() {
    final List<String> storedList = AppService.instance.sharedPreferences
            .getStringList('currentPhoneList') ??
        [];
    return storedList
        .map((item) => MobilePhonesModel.fromJson(jsonDecode(item)))
        .toList();
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController accountnumberController = TextEditingController();
  final TextEditingController sortcodeController = TextEditingController();
  final GlobalKey<FormState> step0Key = GlobalKey<FormState>();
  final GlobalKey<FormState> step1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> step2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> step3Key = GlobalKey<FormState>();

  String ordernumber = '';
  String deliverOptions = 'Royal Mail Digital Label';

  @override
  void onInit() {
    phonesList = getPhoneList();
    fetchValues();
    super.onInit();
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void setDeliveryOptions(String val) {
    deliverOptions = val;
    update();
  }

  Future<void> submitDetails() async {
    if (!(step0Key.currentState?.validate() ?? false)) {
      Get.snackbar('Error', 'Please fill all the required fields');
      return;
    }

    if (isloginAuthService == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      phonesList = getPhoneList();
      final jsonList = phonesList.map((phone) => phone.toJson()).toList();
      final res = OrderService.generateRandomOrderId();
      final response = await supbaseClient.from('orders').insert({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'phone': phoneController.text,
        'customer_id': isloginAuthService!.id!,
        'order_number': res,
        'models': jsonList,
      }).select();

      if (response.isEmpty) {
        Get.back();
        Get.snackbar('Error', 'Failed to submit details');
        return;
      }

      ordernumber = res;
      OrderService.saveLastOrderId(res);
      nextStep();
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      Get.back();
    }
  }

  Future<void> submitAddress() async {
    if (!(step1Key.currentState?.validate() ?? false)) {
      Get.snackbar('Error', 'Please fill all the required fields');
      return;
    }

    if (isloginAuthService == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      final response = await supbaseClient
          .from('orders')
          .update({
            'zip_code': postCodeController.text,
            'street': addressController.text,
          })
          .eq('order_number', ordernumber)
          .select();

      if (response.isEmpty) {
        Get.back();
        Get.snackbar('Error', 'Failed to submit address');
        return;
      }

      nextStep();
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      Get.back();
    }
  }

  Future<void> submitDelivery() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      final response = await supbaseClient
          .from('orders')
          .update({'delivery_option': deliverOptions})
          .eq('order_number', ordernumber)
          .select();

      if (response.isEmpty) {
        Get.back();
        Get.snackbar('Error', 'Failed to submit delivery options');
        return;
      }

      nextStep();
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      Get.back();
    }
  }

  Future<void> submitPayment() async {
    if (!(step3Key.currentState?.validate() ?? false)) {
      Get.snackbar('Error', 'Please fill all the required fields');
      return;
    }

    if (isloginAuthService == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      final response = await supbaseClient
          .from('orders')
          .update({
            'account_name': accountController.text,
            'account_number': accountnumberController.text,
            'sort_code': sortcodeController.text,
            'status': 'booked',
            'timeline': [getCurrentTimelineEntry()]
          })
          .eq('order_number', ordernumber)
          .select();

      if (response.isEmpty) {
        Get.back();
        Get.snackbar('Error', 'Failed to submit payment details');
        return;
      }

      await AppService.instance.sharedPreferences.remove('last_order_id');
      await AppService.instance.sharedPreferences.remove('currentPhoneList');
      await AppService.instance.sharedPreferences.remove('currentPhone');

      await sendOrderProcessingEmail(
        isloginAuthService?.email ?? 'hammad164598@gmail.com',
        "${firstNameController.text} ${lastNameController.text}",
      );

      Get.offAllNamed(Routes.PROFILE_SCREEN);
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      Get.back();
    }
  }

  Map<String, String> getCurrentTimelineEntry() {
    final now = DateTime.now();
    final date = DateFormat('d MMM').format(now);
    final time = DateFormat('h:mm a').format(now);

    return {
      "date": date,
      "time": time,
      "status": "Delivered",
      "description": "Your order has been delivered for submission",
    };
  }

  bool isChecked = false;
  Future<void> fetchValues() async {
    if (isloginAuthService == null) {
      Get.offAllNamed(Routes.HOME);
      return;
    }

    emailController.text = isloginAuthService!.email.toString();
    ordernumber = await OrderService.getLastOrderId() ?? '';

    if (phonesList.isEmpty) {
      Get.offAllNamed(Routes.HOME);
      return;
    }

    if (ordernumber.isEmpty) return;

    final response = await supbaseClient
        .from('orders')
        .select()
        .eq('order_number', ordernumber);

    if (response.isEmpty) {
      if (phonesList.isEmpty) {
        Get.offAllNamed(Routes.HOME);
        return;
      }
      return;
    }

    if (response.first['status'] != null) {
      Get.offAllNamed(Routes.HOME);
      return;
    }

    if (response.isNotEmpty) {
      nextStep();
    }

    if (response.first['zip_code'] != null &&
        response.first['street'] != null) {
      nextStep();
    }
  }
}

class OrderService {
  static const String _lastOrderIdKey = 'last_order_id';

  static Future<void> saveLastOrderId(String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastOrderIdKey, orderId);
  }

  static String generateRandomOrderId() {
    final random = Random();
    final number = random.nextInt(900000000) + 100000000;
    return '#ORD$number';
  }

  static Future<String?> getLastOrderId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastOrderIdKey);
  }
}
