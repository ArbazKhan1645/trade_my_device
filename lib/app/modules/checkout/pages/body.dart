import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/textfield.dart';
import 'bank.dart';
import 'pay.dart';

class StepController extends GetxController {
  var currentStep = 0.obs; // Current step index
  final totalSteps = 4; // Total number of steps

  void nextStep() {
    if (currentStep < totalSteps - 1) {
      currentStep++;
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
    }
  }
}

class StepFlowScreen extends StatelessWidget {
  final StepController controller = Get.put(StepController());

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
                        child: Container(
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
          // Progress Bar

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
                    onTap: () {
                      controller.nextStep();
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
                label: 'First name',
                hintText: 'Enter your first name',
                isRequired: true,
              ),
              SizedBox(height: 10),
              CustomTextField(
                label: 'Last name',
                hintText: 'Enter your first name',
                isRequired: true,
              ),
              SizedBox(height: 10),
              CustomTextField(
                label: 'Email',
                hintText: 'Enter your first name',
                isRequired: true,
              ),
              SizedBox(height: 10),
              CustomTextField(
                label: 'Phone Number',
                hintText: 'Enter your first name',
                isRequired: true,
              ),
            ],
          ),
        );
      case 1:
        return Padding(
          key: ValueKey(1),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Your Address',
                    style: defaultTextStyle.copyWith(fontSize: 18)),
              ),
              Center(
                child: Text(
                    'We need this in case we need to return your device to you',
                    style: defaultTextStyle.copyWith(
                        fontSize: 14, color: Colors.grey)),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Post Code',
                      hintText: 'Enter your first name',
                      isRequired: true,
                    ),
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: Icon(Icons.search),
                      )),
                ],
              ),
              SizedBox(height: 10),
              CustomTextField(
                label: 'Address',
                hintText: 'Enter your first name',
                isRequired: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Enter manually your address',
                      style: defaultTextStyle.copyWith(color: Colors.amber),
                    )),
              ),
              Text('1/3 96 Middleton Street', style: TextStyle(fontSize: 16)),
              Text('Glasgow', style: TextStyle(fontSize: 16)),
              Text('G51 1AE', style: TextStyle(fontSize: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'EditAddress',
                        style: defaultTextStyle.copyWith(color: Colors.amber),
                      )),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.remove_circle_outline))
                ],
              ),
            ],
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
