// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/routes/app_pages.dart';
import '../../../../main.dart';
import '../../../models/users_model.dart/customer_models.dart';
import '../../../repo/fetch_supabase.dart';
import '../../../services/auth/auth_service.dart';

class AuthenticationController extends GetxController {
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;
  final Rxn<CustomerModel> currentPartnerUser = Rxn<CustomerModel>();
  final TextEditingController emailController = TextEditingController();

  void setErrorMessage(String message) {
    errorMessage.value = message;
  }

  void setisLoading(bool val) {
    isLoading.value = val;
  }

  String get email => emailController.text.trim();
  bool get loading => isLoading.value;
  Future<void> callLoginFunction() async {
    setErrorMessage('');
    if (email.isEmpty) {
      setErrorMessage('Fields value cannot be empty');
      return;
    }
    await _supabaseLogin(email);
  }

  Future<void> _supabaseLogin(String email) async {
    try {
      setisLoading(true);
      final value = await supbaseClient.auth
          .signInWithPassword(email: email, password: 'password');
      if (value.user == null) {
        _showErrorSnackbar('Invalid email or password');
        return;
      }
      await _fetchAndStoreCustomer(email);
    } catch (e) {
      setErrorMessage('Error: ${e.toString()}');
    } finally {
      setisLoading(false);
    }
  }

  Future<void> _fetchAndStoreCustomer(String email) async {
    try {
      final customers = await FetchSupabaseRepository.fetch<CustomerModel>(
          'users',
          fromJson: CustomerModel.fromJson,
          eq: {'email': email});
      if (customers == null || customers.isEmpty) {
        _showErrorSnackbar('User not found');
        return;
      }
      currentPartnerUser.value = customers.first;
      AuthService.instance.saveAuthState(currentPartnerUser.value!);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      setErrorMessage('Error fetching user: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    Get.showSnackbar(GetSnackBar(
      title: 'Error',
      message: message,
      duration: const Duration(seconds: 2),
    ));
    setErrorMessage(message);
  }
}
