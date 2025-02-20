// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/routes/app_pages.dart';

class FullScreenDialog extends StatelessWidget {
  const FullScreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          child: Image.asset(
                            'assets/images/trade.jpeg',
                            height: 50,
                          ),
                        ),
                        Text(
                          'TradeMyDevice.com',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    )),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  ListTile(
                      onTap: () {
                        Get.offAllNamed(Routes.HOME);
                      },
                      title: Text('Home'),
                      trailing: Icon(Icons.arrow_forward)),
                  Divider(thickness: 0.5, color: Colors.grey),
                  ListTile(
                      onTap: () {
                        Get.offAllNamed(Routes.SELL_MY_PHONE);
                      },
                      title: Text('Sell my Phone'),
                      trailing: Icon(Icons.arrow_forward)),
                  Divider(thickness: 0.5, color: Colors.grey),
                  ListTile(
                      onTap: () {
                        Get.offAllNamed(Routes.HOW_ITS_WORK);
                      },
                      title: Text('How it works')),
                  Divider(thickness: 0.5, color: Colors.grey),
                  ListTile(
                      onTap: () {
                        Get.offAllNamed(Routes.SUPPORT_CENTER);
                      },
                      title: Text('Support Center')),
                  Divider(thickness: 0.5, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
