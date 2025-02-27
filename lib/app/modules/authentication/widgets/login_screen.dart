// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/core/utils/thems/theme.dart';
import 'package:trademydevice/app/routes/app_pages.dart';
import '../controller/authentication_controller.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});

  final AuthenticationController controller =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/trade.jpeg', height: 180),
          Text('Login to your account',
              style: defaultTextStyle.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w400)),
          SizedBox(height: 20),
          TextFieldWidget(
              hintText: 'Enter your Email',
              controller: controller.emailController),
          SizedBox(height: 10),
          Obx(() => controller.errorMessage.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red)),
                )
              : const SizedBox()),
          SizedBox(height: 10),
          _loginButton(),
          SizedBox(height: 10),
          _signUpText(),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Obx(
      () => MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: controller.isLoading.value
            ? null
            : () async => await controller.callLoginFunction(),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.amber,
          ),
          child: Center(
            child: controller.isLoading.value
                ? const SpinKitThreeBounce(color: Colors.black, size: 20)
                : const Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
          ),
        ),
      ),
    );
  }

  /// Signup text button
  Widget _signUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don’t have an account?',
            style: defaultTextStyle.copyWith(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
        TextButton(
          onPressed: () {
            Get.back();
            Get.offAllNamed(Routes.SELL_MY_PHONE);
          },
          child: Text('Trade your phone Now',
              style:
                  defaultTextStyle.copyWith(color: Colors.black, fontSize: 16)),
        ),
      ],
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      this.iconbutton,
      required this.hintText,
      this.controller,
      this.observe = false});
  final String hintText;
  final bool observe;
  final IconButton? iconbutton;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
        obscureText: observe,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: iconbutton,
            contentPadding: const EdgeInsets.all(12),
            border: InputBorder.none,
            hintText: hintText),
      ),
    );
  }
}
