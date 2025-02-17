import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!controller.isloginAuthService)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email address*', style: defaultTextStyle),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: controller.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            // Regex for email validation
                            String pattern =
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'you@example.com',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12.0),
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),

                  // Checkbox and Label
                  Row(
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
                            style:
                                defaultTextStyle.copyWith(color: Colors.grey)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Button
                  GestureDetector(
                    onTap: isChecked
                        ? () {
                            print('object');
                            controller.handleAccountCreation();
                          }
                        : null,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                        color: isChecked ? Colors.amber : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: controller.isLoading.value
                          ? Center(
                              child: const SpinKitThreeBounce(
                                  color: Colors.black, size: 20),
                            )
                          : Text(
                              'Get My Price',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
