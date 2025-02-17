import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/textfield.dart';
import '../controllers/checkout_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isChecked = false;

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
              '• We’ll pay £329 into your bank account\n• Your details are used to make payment to you\n• All bank account information will be deleted after use',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildTextField(
                label: 'Account Name *',
                controller: controller.accountController),
            SizedBox(height: 16),
            _buildTextField(
                label: 'Account Number *',
                controller: controller.accountnumberController),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildTextField(
                        label: 'Sort Code*',
                        maxLength: 3,
                        controller: controller.sortcodeController)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'I confirm that I am the account holder and can authorise payments from this account, and this is not a business account.',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      int maxLength = 30,
      required TextEditingController controller}) {
    return CustomTextField(
      controller: controller,
      label: label,
      hintText: 'Enter your first name',
      isRequired: true,
    );
  }
}
