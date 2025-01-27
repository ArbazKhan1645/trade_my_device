// ignore_for_file: depend_on_referenced_packages

import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';
import 'package:webuywesell/app/routes/app_pages.dart';

import 'filter_widget.dart';

class SellMyIPhoneScreen extends StatelessWidget {
  const SellMyIPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double getPadding(double width) {
        if (width >= 1200) {
          return 150.0;
        } else if (width >= 800) {
          return 50.0;
        } else {
          return 20.0;
        }
      }

      double padding = getPadding(constraints.maxWidth);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: padding, right: padding, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sell My Phone For Cash',
                      textAlign: TextAlign.center,
                      style: defaultTextStyle.copyWith(
                          fontSize: constraints.maxWidth >= 800 ? 40 : 28,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 10),
                  Text(
                      'Discover How Much Your iPhone Is Worth in Under 60 Seconds',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: defaultTextStyle.copyWith(
                          fontSize: constraints.maxWidth >= 800 ? 24 : 20,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 10),
                  Text(
                      'Are you looking to get the best price for your old iPhone, Samsung, Google or Huawei phone? We can buy your phone whether it is in good condition or broken.',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: defaultTextStyle.copyWith(
                          color: Color.fromARGB(255, 129, 140, 152),
                          fontSize: constraints.maxWidth >= 800 ? 16 : 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  if (constraints.maxWidth <= 1200) {
                    return Container();
                  }
                  return SizedBox(
                    width: 300,
                    child: FilterWidget(),
                  );
                }),
                Expanded(child: Builder(builder: (context) {
                  if (constraints.maxWidth <= 600) {
                    return ListView.separated(
                        separatorBuilder: (context, index) =>
                            Container(height: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: iPhones.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final iPhone = iPhones[index];
                          return GestureDetector(
                            onTap: () {
                              Get.offNamed(Routes.DEVICE_INFO);
                            },
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: const Color(0xFFe5e7eb)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        iPhone['image']!,
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            'Apple',
                                            textAlign: TextAlign.center,
                                            style: defaultTextStyle.copyWith(
                                              fontSize: 14,
                                              color: const Color.fromARGB(
                                                  255, 129, 140, 152),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, bottom: 0),
                                          child: Text(
                                            iPhone['name']!,
                                            style: defaultTextStyle.copyWith(
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return AutoHeightGridView(
                    itemCount: iPhones.length,
                    crossAxisCount: constraints.maxWidth <= 1200 ? 4 : 4,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    shrinkWrap: true,
                    builder: (context, index) {
                      final iPhone = iPhones[index];
                      return GestureDetector(
                        onTap: () {
                          Get.offNamed(Routes.DEVICE_INFO);
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFe5e7eb)),
                          ),
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
                                    color: const Color.fromARGB(
                                        255, 129, 140, 152),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, bottom: 10),
                                child: Text(
                                  iPhone['name']!,
                                  style:
                                      defaultTextStyle.copyWith(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    });
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
