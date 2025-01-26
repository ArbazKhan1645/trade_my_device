// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';
import 'package:webuywesell/app/routes/app_pages.dart';

import 'filter_widget.dart';

class SellMyIPhoneScreen extends StatelessWidget {
  const SellMyIPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 150, right: 150, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sell My Phone For Cash',
                    textAlign: TextAlign.center,
                    style: defaultTextStyle.copyWith(
                        fontSize: 32, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                Text(
                    'Discover How Much Your iPhone Is Worth in Under 60 Seconds',
                    textAlign: TextAlign.center,
                    style: defaultTextStyle.copyWith(
                        fontSize: 24, fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                Text(
                    'Are you looking to get the best price for your old iPhone, Samsung, Google or Huawei phone? We can buy your phone whether it is in good condition or broken.',
                    textAlign: TextAlign.center,
                    style: defaultTextStyle.copyWith(
                        color: Color.fromARGB(255, 129, 140, 152),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 150, right: 150),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300,
                child: FilterWidget(),
              ),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: iPhones.map((iPhone) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 5 * 16) / 8,
                      height: 200,
                      child: GestureDetector(
                        onTap: () {
                          Get.offNamed(Routes.DEVICE_INFO);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFFe5e7eb))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    iPhone['image']!,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  'Apple',
                                  textAlign: TextAlign.center,
                                  style: defaultTextStyle.copyWith(
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 129, 140, 152)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(iPhone['name']!,
                                    style: defaultTextStyle.copyWith(
                                        fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

final List<Map<String, String>> iPhones = [
  {'name': 'iPhone 13', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 11', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 12', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 11', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 12', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 11', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 12', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 11', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 12', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 11', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 12', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 13 Pro', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro Max', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14', 'image': 'assets/images/mobile.png'},
  {'name': 'iPhone 14 Pro', 'image': 'assets/images/mobile.png'},
];
