// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/textfield.dart';
import '../controllers/checkout_controller.dart';
import 'bank.dart';
import 'pay.dart';

class StepFlowScreen extends StatelessWidget {
  final CheckoutController controller = Get.put(CheckoutController());

  StepFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(color: Colors.white),
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
                              '£${controller.phonesList.fold<num>(0, (sum, element) => sum + (element?.manage_price ?? 0))}.00 guaranteed for the next 30 days',
                          style: defaultTextStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          children: []),
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
          ),
          SizedBox(height: 20),
          // AnimatedSwitcher for screens
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              width: constraints.maxWidth <= 600
                  ? (constraints.maxWidth - 50)
                  : 560,
              child: Column(
                children: [
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: _getStepWidget(controller.currentStep.value)),
                  SizedBox(height: 20),
                  GestureDetector(
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
                  ),
                  SizedBox(height: 40)
                ],
              ),
            );
          }),
          SizedBox(height: 40)
        ],
      );
    });
  }

  // Step widgets based on the index
  Widget _getStepWidget(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return Padding(
          key: ValueKey(0),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.step0Key,
            child: Column(
              children: [
                Text('Your details',
                    style: defaultTextStyle.copyWith(fontSize: 18)),
                Text(
                    'We need this in case we need to contact you about your sale',
                    style: defaultTextStyle.copyWith(
                        fontSize: 14, color: Colors.grey)),
                SizedBox(height: 20),
                CustomTextField(
                  controller: controller.firstNameController,
                  label: 'First name',
                  hintText: 'Enter your first name',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: controller.lastNameController,
                  label: 'Last name',
                  hintText: 'Enter your last name',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: controller.phoneController,
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  isRequired: true,
                ),
              ],
            ),
          ),
        );
      case 1:
        return Padding(
          key: ValueKey(1),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.step1Key,
            child: Column(
              children: [
                Text('Your Address',
                    style: defaultTextStyle.copyWith(fontSize: 18)),
                CustomTextField(
                  controller: controller.postCodeController,
                  label: 'Post Code',
                  hintText: 'Enter your post code',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: controller.addressController,
                  label: 'Address',
                  hintText: 'Enter your address',
                  isRequired: true,
                ),
              ],
            ),
          ),
        );
      case 2:
        return Center(key: ValueKey(2), child: DeliveryOptionWidget());
      case 3:
        return Center(key: ValueKey(3), child: PaymentScreen());
      default:
        return const SizedBox.shrink();
    }
  }
}
