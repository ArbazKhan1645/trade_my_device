import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/routes/app_pages.dart';

import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/base.dart';
import '../../sell_my_phone/dialog.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(
      screens: [
        LayoutBuilder(builder: (context, constraints) {
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
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: 120,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Here is what you are selling',
                            style: defaultTextStyle.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: padding, right: padding, top: 40),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmallScreen = constraints.maxWidth <= 600;
                    return SingleChildScrollView(
                      child: isSmallScreen
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // First Section
                                buildFirstSection(context),
                                const SizedBox(height: 32),
                                // Second Section
                                buildSecondSection(),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // First Section
                                Expanded(child: buildFirstSection(context)),
                                const SizedBox(width: 32),
                                // Second Section
                                Expanded(child: buildSecondSection()),
                              ],
                            ),
                    );
                  },
                ),
              )
            ],
          );
        }),
      ],
    );
  }
}

Widget buildFirstSection(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/mobile.png', // Replace with actual image
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'iPhone 13 Pro',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showAddIMEIDialog(context);
                },
                child: const Text(
                  'Add an IMEI',
                  style: TextStyle(color: Colors.amber, fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Power: Yes'),
              const Text('Cracked: No'),
              const Text('Network: Unlocked'),
              const Text('Storage: 128GB'),
              const Text('Condition: Good'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.amber, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
      Divider(height: 32, thickness: 1, color: Colors.grey.shade300),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get £5 extra',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add another device over £50 and we\'ll give you £5 extra!',
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Terms & Conditions apply.',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Add another device',
                    style: TextStyle(color: Colors.amber, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Divider(height: 32, thickness: 1, color: Colors.grey.shade300),
    ],
  );
}

Widget buildSecondSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'We\'ll pay you',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          '£329.00',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Get.offNamed(Routes.CHECKOUT);
          },
          child: Container(
            width: double.infinity,
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
        const SizedBox(height: 16),
        const Text(
          'By clicking Continue, you confirm you have read and agree to our Terms & Conditions and our Privacy policy.',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
