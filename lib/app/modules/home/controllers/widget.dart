import 'package:flutter/material.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';

class DeviceWorthScreen extends StatelessWidget {
  const DeviceWorthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A008F),
            Color(0xFF00CCBC),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 150, right: 150),
          child: Row(
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
                            child: TextField(
                              decoration: InputDecoration(
                                hintText:
                                    'Search for your device or IMEI number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF00AA),
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
                                    color: Colors.white,
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
          ),
        ),
      ),
    );
  }
}
