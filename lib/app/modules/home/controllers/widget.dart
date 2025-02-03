import 'package:flutter/material.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';
import 'package:webuywesell/app/repo/network_repository.dart';

import '../widgets/iemei_field.dart';

class DeviceWorthScreen extends StatelessWidget {
  const DeviceWorthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double getPadding(double width) {
        if (width >= 1200) {
          return 150.0; // Large screen
        } else if (width >= 800) {
          return 50.0; // Medium screen
        } else {
          return 20.0; // Small screen
        }
      }

      double padding = getPadding(constraints.maxWidth);
      return AnimatedContainer(
        height: constraints.maxWidth <= 700 ? 400 : 300,
        duration: Duration(milliseconds: 500),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/footer.png'),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Builder(builder: (context) {
              if (constraints.maxWidth <= 700) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text('How much is your device worth?',
                        style: defaultTextStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: IMEITextField(
                              onIMEIComplete: (imei) {
                                callApiKing(imei);
                              }, // Pass the callback
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xffFFC000),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Search',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('How to find your IMEI number?',
                        style: defaultTextStyle.copyWith(color: Colors.white)),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Image.asset(
                            'assets/images/phones.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('How much is your device worth?',
                            style: defaultTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 24)),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: IMEITextField(
                                  onIMEIComplete: (imei) {
                                    callApiKing(imei);
                                  }, // Pass the callback
                                ),
                              ),
                              Container(
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: Color(0xffFFC000),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'Search',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text('How to find your IMEI number?',
                            style:
                                defaultTextStyle.copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Image.asset(
                          'assets/images/phones.png',
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      );
    });
  }
}
