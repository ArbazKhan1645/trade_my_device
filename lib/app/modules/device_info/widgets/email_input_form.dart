// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/core/utils/thems/theme.dart';
import 'package:trademydevice/app/services/app/app_service.dart';
import '../controllers/device_info_controller.dart';

class EmailFormWidget extends StatefulWidget {
  const EmailFormWidget({super.key});

  @override
  _EmailFormWidgetState createState() => _EmailFormWidgetState();
}

class _EmailFormWidgetState extends State<EmailFormWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceInfoController>(
      init: DeviceInfoController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!controller.isloginAuthService)
                  _buildEmailField(controller),
                _buildCheckboxSection(),
                const SizedBox(height: 10),
                _buildSubmitButton(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmailField(DeviceInfoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email address*', style: defaultTextStyle),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller.emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email';
            }
            const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
            final regExp = RegExp(pattern);
            if (!regExp.hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'you@example.com',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black38),
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildCheckboxSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Expanded(
          child: Text(
            'In order to complete your order we may need to contact you, please check here to agree to this. We might also contact you with occasional updates and offers. You can unsubscribe at any time by visiting “My Account” Subject to our Privacy Policy',
            style: defaultTextStyle.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(DeviceInfoController controller) {
    return GestureDetector(
      onTap: isChecked
          ? () {
              if (_isMaxDevicesReached()) {
                Get.snackbar(
                  'Alert Notification',
                  'You can only sell 2 devices at a time. View your basket to remove an item.',
                );
                return;
              }
              controller.handleAccountCreation();
            }
          : null,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: isChecked ? Colors.amber : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: controller.isLoading.value
            ? const Center(
                child: SpinKitThreeBounce(color: Colors.black, size: 20),
              )
            : const Text(
                'Get My Price',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  bool _isMaxDevicesReached() {
    final List<String> storedList = AppService.instance.sharedPreferences
            .getStringList('currentPhoneList') ??
        [];
    return storedList.length == 2;
  }
}
