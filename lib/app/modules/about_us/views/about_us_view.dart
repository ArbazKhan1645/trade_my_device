import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';
import 'package:webuywesell/app/core/widgets/base.dart';
import 'package:webuywesell/app/modules/about_us/widget/aboutus_body.dart';
import 'package:webuywesell/app/modules/home/controllers/footer.dart';
import 'package:webuywesell/app/modules/home/controllers/home.controller.dart';

import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(screens: [
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
                      text: 'About Us',
                      style: defaultTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
      AboutusBodyScreen(),
      SizedBox(
        child: SizedBox(
            height: 80,
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth >= 700) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FeatureItem(
                      icon: Icons.monetization_on_outlined,
                      text: 'We pay more than networks',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const FeatureItem(
                      icon: Icons.account_balance_outlined,
                      text: 'Fast payment to your bank',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const FeatureItem(
                      icon: Icons.phone_iphone_outlined,
                      text: 'Send your device to us for free',
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const FeatureItemMobile(
                    icon: Icons.monetization_on_outlined,
                    text: 'We pay more than networks',
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  const FeatureItemMobile(
                    icon: Icons.account_balance_outlined,
                    text: 'Fast payment to your bank',
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  const FeatureItemMobile(
                    icon: Icons.phone_iphone_outlined,
                    text: 'Send your device to us for free',
                  ),
                ],
              );
            })),
      ),
      MobileFooterPageView(),
    ]);
  }
}
