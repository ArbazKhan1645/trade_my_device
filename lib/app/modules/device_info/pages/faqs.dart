// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';

class WeBuyAnyPhoneWidget extends StatelessWidget {
  const WeBuyAnyPhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Image.asset('assets/vodafone_logo.png', height: 40), // Replace with your asset path
        //     SizedBox(width: 8),
        //     Image.asset('assets/o2_logo.png', height: 40), // Replace with your asset path
        //     SizedBox(width: 8),
        //     Image.asset('assets/ee_logo.png', height: 40), // Replace with your asset path
        //   ],
        // ),
        SizedBox(height: 16),
        Text('We pay more than your network provider',
            style: defaultTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w400)),
        SizedBox(height: 8),
        Text(
            'Get more value for your trade - We pay more than Vodafone, O2 & EE! See how much you could get today.',
            style: defaultTextStyle.copyWith(
                color: Color.fromARGB(255, 129, 140, 152),
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        Divider(height: 32, thickness: 1, color: Colors.grey[300]),

        // Section 2
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.teal, size: 30),
            SizedBox(width: 8),
            Expanded(
              child: Text('We are a Phonecheck certified business',
                  style: defaultTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
            'Every handset is functionality tested & data wiped using industry-leading software for your peace of mind.',
            style: defaultTextStyle.copyWith(
                color: Color.fromARGB(255, 129, 140, 152),
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        Divider(height: 32, thickness: 1, color: Colors.grey[300]),

        // Section 3
        Text('More great reasons to sell with us',
            style: defaultTextStyle.copyWith(
                color: Color.fromARGB(255, 129, 140, 152),
                fontSize: 16,
                fontWeight: FontWeight.w400)),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReasonItem('We offer the best prices'),
            _buildReasonItem('It’s free and easy to post your device'),
            _buildReasonItem(
                'We’ve bought over 1 million devices from customers'),
            _buildReasonItem(
                '14 day price guarantee - longer than our competitors'),
            _buildReasonItem('We accept broken devices too'),
            _buildReasonItem('Fast, secure payment into your bank account'),
            _buildReasonItem('We pay more than the networks'),
            _buildReasonItem('30 Day Free McAfee included'),
          ],
        ),
      ],
    );
  }

  Widget _buildReasonItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.teal, size: 24),
          SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: defaultTextStyle.copyWith(
                    color: Color.fromARGB(255, 129, 140, 152),
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }
}
