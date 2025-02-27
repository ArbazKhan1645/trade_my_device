// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/textfield.dart';
import '../controllers/checkout_controller.dart';
import 'bank_details_widget.dart';
import 'delivery_options_widget.dart';

class CheckOutBodyScreen extends StatelessWidget {
  final CheckoutController controller = Get.put(CheckoutController());

  CheckOutBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const SizedBox(height: 40),
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildStepContent(constraints),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: 90,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text:
                      '£${controller.phonesList.fold<num>(0, (sum, element) => sum + (element.manage_price ?? 0))}.00 guaranteed Price',
                  style: defaultTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: LinearProgressIndicator(
                      value: (controller.currentStep.value + 1) /
                          controller.totalSteps,
                      backgroundColor: Colors.grey[300],
                      color: Colors.amber,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(BoxConstraints constraints) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        width: constraints.maxWidth <= 600 ? (constraints.maxWidth - 50) : 560,
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _getStepWidget(controller.currentStep.value),
            ),
            const SizedBox(height: 20),
            _buildContinueButton(),
            const SizedBox(height: 40),
          ],
        ),
      );
    });
  }

  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: () async {
        switch (controller.currentStep.value) {
          case 0:
            await controller.submitDetails();
            break;
          case 1:
            await controller.submitAddress();
            break;
          case 2:
            await controller.submitDelivery();
            break;
          case 3:
            await controller.submitPayment();
            break;
          default:
            break;
        }
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getStepWidget(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return _buildStep0();
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep0() {
    return Padding(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: controller.step0Key,
        child: Column(
          children: [
            Text(
              'Your details',
              style: defaultTextStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'We need this in case we need to contact you about your sale',
              style:
                  defaultTextStyle.copyWith(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.firstNameController,
              label: 'First name',
              hintText: 'Enter your first name',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: controller.lastNameController,
              label: 'Last name',
              hintText: 'Enter your last name',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: controller.phoneController,
              label: 'Phone Number',
              hintText: 'Enter your phone number',
              isRequired: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Padding(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: controller.step1Key,
        child: Column(
          children: [
            Text(
              'Your Address',
              style: defaultTextStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.postCodeController,
              label: 'Post Code',
              hintText: 'Enter your post code',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: controller.addressController,
              label: 'Address',
              hintText: 'Enter your address',
              isRequired: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return Center(
      key: const ValueKey(2),
      child: DeliveryOptionWidget(),
    );
  }

  Widget _buildStep3() {
    return Center(
      key: const ValueKey(3),
      child: BankDetailsWidget(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool isRequired = false,
  }) {
    return CustomTextField(
      controller: controller,
      label: label,
      hintText: hintText,
      isRequired: isRequired,
    );
  }
}
