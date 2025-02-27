// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/core/utils/constants/appcolors.dart';
import 'package:trademydevice/app/routes/app_pages.dart';

import '../../../core/utils/thems/theme.dart';

class SellPhoneByCategoryScreen extends StatefulWidget {
  const SellPhoneByCategoryScreen({super.key});

  @override
  State<SellPhoneByCategoryScreen> createState() =>
      _SellPhoneByCategoryScreenState();
}

class _SellPhoneByCategoryScreenState extends State<SellPhoneByCategoryScreen> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double getPadding(double width) {
        if (width >= 1200) {
          return 150.0;
        } else if (width >= 800) {
          return 50.0;
        } else {
          return 10.0;
        }
      }

      double padding = getPadding(constraints.maxWidth);
      return Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Sell your phone online',
                style: defaultTextStyle.copyWith(fontSize: 20)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.05)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoStep(
                        icon: Icons.search,
                        title: 'Search',
                        description: 'Select the device you want to sell',
                      ),
                      SizedBox(width: 4),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      SizedBox(width: 4),
                      InfoStep(
                        icon: Icons.local_shipping,
                        title: 'Send',
                        description: 'Send it to us for free',
                      ),
                      SizedBox(width: 4),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      SizedBox(width: 4),
                      InfoStep(
                        icon: Icons.currency_pound,
                        title: 'Get paid',
                        description: 'Fast payments',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sell by category',
                    style: defaultTextStyle.copyWith(fontSize: 20)),
                TextButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.SELL_MY_PHONE);
                    },
                    child: Text(
                      'View ALl',
                      style: defaultTextStyle.copyWith(color: Colors.black),
                    ))
              ],
            ),
            const SizedBox(height: 16),
            constraints.maxWidth >= 600
                ? Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed(Routes.SELL_MY_PHONE, arguments: {
                            'brand': 'Apple',
                          });
                        },
                        child: const CategoryCard(
                          title: 'Sell my Apple iPhone',
                          imageUrl: 'assets/images/mobile2.png',
                          logo: Icons.apple,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed(Routes.SELL_MY_PHONE, arguments: {
                            'brand': 'Samsung',
                          });
                        },
                        child: const CategoryCard(
                          title: 'Sell my Samsung Galaxy',
                          imageUrl: 'assets/images/mobile2.png',
                          logo: Icons.android,
                        ),
                      ),
                    ),
                  ])
                : Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    controller: _controller,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed(Routes.SELL_MY_PHONE);
                              },
                              child: const CategoryCard(
                                title: 'Sell my Apple iPhone',
                                imageUrl: 'assets/images/mobile2.png',
                                logo: Icons.apple,
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed(Routes.SELL_MY_PHONE);
                              },
                              child: const CategoryCard(
                                title: 'Sell my Samsung Galaxy',
                                imageUrl: 'assets/images/mobile2.png',
                                logo: Icons.android,
                              ),
                            ),
                          ]),
                    ),
                  ),
            const SizedBox(height: 50),
          ],
        ),
      );
    });
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final IconData logo;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(logo, size: 40, color: Colors.black),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                imageUrl,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: defaultTextStyle.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class InfoStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoStep({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: AppColors.primarycolor),
          const SizedBox(height: 8),
          Text(title, style: defaultTextStyle.copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text(description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: defaultTextStyle.copyWith(
                  fontSize: 12, color: Color.fromARGB(255, 129, 140, 152))),
        ],
      ),
    );
  }
}
