// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/models/users_model.dart/customer_models.dart';
import 'package:webuywesell/app/services/auth/auth_service.dart';

import '../../../../main.dart';
import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/textfield.dart';
import 'bank.dart';
import 'pay.dart';

class StepController extends GetxController {
  var currentStep = 0.obs;
  final totalSteps = 4;
  CustomerModel? get isloginAuthService {
    return AuthService.instance.authCustomer;
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
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

  Future<void> submitDetails() async {
    if (step0Key.currentState?.validate() ?? false) {
      if (isloginAuthService == null) return;
      final response = await supbaseClient
          .from('users')
          .update({
            'first_name': firstNameController.text,
            'last_name': lastNameController.text,
            // 'email': emailController.text,
            'phone': phoneController.text,
          })
          .eq('id', isloginAuthService!.id!)
          .select();

      if (response.isEmpty) {
        print("Error inserting details:");
        return;
      }

      nextStep();
    }
  }

  Future<void> submitAddress() async {
    if (step1Key.currentState?.validate() ?? false) {
      if (isloginAuthService == null) return;
      final response = await supbaseClient
          .from('users')
          .update({
            'zip_code': postCodeController.text,
            'street': addressController.text,
          })
          .eq('id', isloginAuthService!.id!)
          .select();

      if (response.isEmpty) {
        print("Error inserting address");
        return;
      }

      nextStep();
    }
  }

  Future<void> submitDelivery() async {
    nextStep();
  }

  Future<void> submitPayment() async {
    nextStep();
  }
}

class StepFlowScreen extends StatelessWidget {
  final StepController controller = Get.put(StepController());

  StepFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 90,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '£329 guaranteed for the next',
                          style: defaultTextStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: '  1m 39s',
                              style: TextStyle(
                                color: Colors.amber,
                              ),
                            ),
                          ]),
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
                  controller: controller.emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
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
