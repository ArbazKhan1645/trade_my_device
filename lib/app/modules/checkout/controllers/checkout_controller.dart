// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webuywesell/app/modules/checkout/api.dart';
import 'package:webuywesell/app/routes/app_pages.dart';
import '../../../../main.dart';
import '../../../models/users_model.dart/customer_models.dart';
import '../../../services/app/app_service.dart';
import '../../../services/auth/auth_service.dart';
import 'package:intl/intl.dart';
import '../../sell_my_phone/models/mobile_phones_model.dart';

class CheckoutController extends GetxController {
  var currentStep = 0.obs;
  final totalSteps = 4;
  CustomerModel? get isloginAuthService {
    return AuthService.instance.authCustomer;
  }

  List<MobilePhonesModel?> phonesList = [];
  List<MobilePhonesModel> getPhoneList() {
    final List<String> storedList = AppService.instance.sharedPreferences
            .getStringList('currentPhoneList') ??
        [];
    return (storedList
            .map((item) => jsonDecode(item) as Map<String, dynamic>)
            .toList())
        .map((w) => MobilePhonesModel.fromJson(w))
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

  String ordernumber = '';

  Future<void> submitDetails() async {
    if (step0Key.currentState?.validate() ?? false) {
      if (isloginAuthService == null) return;
      phonesList = getPhoneList();
      final jsonList = phonesList.map((phone) => phone?.toJson()).toList();
      final res = OrderService.generateRandomOrderId();
      final response = await supbaseClient.from('orders').insert({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'phone': phoneController.text,
        'customer_id': isloginAuthService!.id!,
        'order_number': res,
        'models': jsonList
      }).select();

      if (response.isEmpty) {
        return;
      }

      ordernumber = res;

      OrderService.saveLastOrderId(res);

      // AuthService.instance
      //     .saveAuthState(CustomerModel.fromJson(response.first));

      nextStep();
    }
  }

  Future<void> submitAddress() async {
    if (step1Key.currentState?.validate() ?? false) {
      if (isloginAuthService == null) return;
      final response = await supbaseClient
          .from('orders')
          .update({
            'zip_code': postCodeController.text,
            'street': addressController.text,
          })
          .eq('order_number', ordernumber)
          .select();

      if (response.isEmpty) {
        return;
      }
      nextStep();
    }
  }

  String deliverOptions = 'Royal Mail Digital Label';
  setdeliveryOptions(String val) {
    deliverOptions = val;
    update();
  }

  Future<void> submitDelivery() async {
    final response = await supbaseClient
        .from('orders')
        .update({'delivery_option': deliverOptions})
        .eq('order_number', ordernumber)
        .select();
    nextStep();
  }

  Future<void> submitPayment() async {
    if (step3Key.currentState?.validate() ?? false) {
      if (isloginAuthService == null) return;
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
        return;
      }
      await AppService.instance.sharedPreferences.remove('last_order_id');
      await AppService.instance.sharedPreferences.remove('currentPhoneList');
      await AppService.instance.sharedPreferences.remove('currentPhone');
      final res = await sendOrderProcessingEmail(
          isloginAuthService?.email ?? 'hammad164598@gmail.com'.toString(),
          "${firstNameController.text} ${lastNameController.text}");
      print(res);
      print(isloginAuthService?.email ?? 'hammad164598@gmail.com'.toString());
      print("${firstNameController.text} ${lastNameController.text}");
      Get.offAllNamed(Routes.PROFILE_SCREEN);
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

  @override
  void onInit() {
    phonesList = getPhoneList();
    fetchvalues();
    super.onInit();
  }

  fetchvalues() async {
    emailController.text = isloginAuthService!.email.toString();
    ordernumber = await OrderService.getLastOrderId() ?? '';
    if (phonesList.isEmpty) {
      Get.offAllNamed(Routes.HOME);
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
    final number = random.nextInt(900000000) + 100000000; // 9-digit number
    return '#ORD$number';
  }

  /// Fetches the last order ID from SharedPreferences
  static Future<String?> getLastOrderId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastOrderIdKey);
  }
}
