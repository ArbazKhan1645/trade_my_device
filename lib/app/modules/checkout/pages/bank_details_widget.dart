// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/textfield.dart';
import '../controllers/checkout_controller.dart';

class BankDetailsWidget extends StatefulWidget {
  const BankDetailsWidget({super.key});

  @override
  _BankDetailsWidgetState createState() => _BankDetailsWidgetState();
}

class _BankDetailsWidgetState extends State<BankDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CheckoutController>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: controller.step3Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('How you will be paid',
                  style: defaultTextStyle.copyWith(fontSize: 18)),
            ),
            Center(
              child: Text(
                  'We need this in case we need to return your device to you',
                  style: defaultTextStyle.copyWith(
                      fontSize: 14, color: Colors.grey)),
            ),
            SizedBox(height: 20),
            Text(
              '• We’ll pay into your bank account\n• Your details are used to make payment to you\n• All bank account information will be deleted after use',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an Account Name';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9 ]{2,50}$").hasMatch(value)) {
                    return 'Account Name should be 2-50 characters long (letters, numbers, spaces only)';
                  }
                  return null;
                },
                label: 'Account Name',
                controller: controller.accountController),
            SizedBox(height: 16),
            _buildTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an Account Number';
                  }
                  if (!RegExp(r"^\d{8}$").hasMatch(value)) {
                    return 'Account Number must be exactly 8 digits';
                  }
                  return null;
                },
                label: 'Account Number',
                controller: controller.accountnumberController),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Sort Code';
                          }
                          if (!RegExp(r"^\d{6}$").hasMatch(value)) {
                            return 'Sort Code must be exactly 6 digits';
                          }
                          return null;
                        },
                        label: 'Sort Code',
                        maxLength: 6,
                        controller: controller.sortcodeController)),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      final String? Function(String?)? validator,
      int maxLength = 30,
      required TextEditingController controller}) {
    return CustomTextField(
      controller: controller,
      validator: validator,
      label: label,
      hintText: 'Enter your $label',
      isRequired: true,
    );
  }
}
