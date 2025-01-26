import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cate.dart';
import 'footer.dart';
import 'widget.dart';

class HomeController extends GetxController {
  List<Widget> getDashboardViewBodyScreen = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 150, right: 150),
          child: SizedBox(
            height: 80,
            child: Row(
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
            ),
          ),
        ),
        const DeviceWorthScreen(),
        // PopularBrandsWidget(),
        const SellPhoneScreen(),
        MobileFooterPageView(),
        // const SellSmartDevicesScreen(),
        // const SizedBox(height: 50),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Image.asset(
        //         'assets/images/ph1.png', // Replace with a valid asset path
        //       ),
        //     ),
        //     const SizedBox(width: 16),
        //     const Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Join thousands of satisfied customers',
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.w400,
        //               color: Colors.grey,
        //             ),
        //           ),
        //           SizedBox(height: 8),
        //           Text(
        //             'We buy a phone every minute!',
        //             style: TextStyle(
        //               fontSize: 24,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           ),
        //           SizedBox(height: 8),
        //           Text(
        //             'As the largest independent recycler in the UK, you can sell with confidence. Join thousands of satisfied customers today!',
        //             style: TextStyle(
        //               fontSize: 14,
        //               color: Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 50),
        // MyAppMobile(),
        // MyAppguide(),
        // const SizedBox(height: 100)
      ],
    ),
  ];
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItem({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF00CCBC), size: 28),
          const SizedBox(width: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
