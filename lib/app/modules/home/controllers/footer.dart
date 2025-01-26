import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/thems/theme.dart';

class MobileFooterPageView extends StatelessWidget {
  const MobileFooterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/footer.png'), fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.only(left: 200, right: 200),
        child: Column(
          children: [
            SizedBox(height: 70),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InformationWidget(
                    heading: 'About',
                    options: [
                      'About Us',
                      'Sell an Item',
                      'Careers',
                      'Franchising',
                      'CeX Blog',
                      'Press',
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: InformationWidget(
                    heading: 'About',
                    options: [
                      'About Us',
                      'Sell an Item',
                      'Careers',
                      'Franchising',
                      'CeX Blog',
                      'Press',
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: InformationWidget(
                    heading: 'About',
                    options: [
                      'About Us',
                      'Sell an Item',
                      'Careers',
                      'Franchising',
                      'CeX Blog',
                      'Press',
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(child: NewsLetterWidget()),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              color: Color.fromARGB(255, 129, 140, 152),
            ),
            SizedBox(height: 20),
            Text(
              '©2025 TradeMyDevice Limited. All rights reserved | Company No. 8321525 - VAT No. GB153510637',
              style: GoogleFonts.cabin(
                color: Color.fromARGB(255, 129, 140, 152),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    Key? key,
    required this.heading,
    required this.options,
  }) : super(key: key);

  final String heading;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.cabin(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  // Handle onTap for each option here
                  print('$option tapped');
                },
                child: Text(
                  option,
                  style: GoogleFonts.cabin(
                    color: Color.fromARGB(255, 129, 140, 152),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class NewsLetterWidget extends StatelessWidget {
  const NewsLetterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NewsLetter',
          style: defaultTextStyle.copyWith(fontSize: 14, color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.white,
              )),
              child: const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none),
              ),
            )),
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), color: Colors.orange),
              child: const Center(
                child: Text(
                  'Send',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            'Sector F17 Street 46 , house 1137 , MPCHS , Islamabad , Pakistan ',
            style: defaultTextStyle.copyWith(
                fontSize: 14,
                color: Color.fromARGB(255, 129, 140, 152),
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
