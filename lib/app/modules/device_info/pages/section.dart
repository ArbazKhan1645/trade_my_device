// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webuywesell/app/modules/device_info/pages/form.dart';

import '../../../core/utils/thems/theme.dart';
import 'faqs.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  int? selectedQuestion = 0;

  final List<String> questions = [
    'Does your device turn on?',
    'What storage capacity is it?',
    'Is the front or back cracked?',
    'What condition best describes your device?',
  ];

  final List<Widget> answers = [
    Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFe5e7eb))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.confirmation_number_outlined), Text('Yes')],
            ),
          )),
          SizedBox(width: 20),
          Expanded(
              child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFe5e7eb))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.close_outlined), Text('No')],
            ),
          )),
        ],
      ),
    ),
    Wrap(
      children: ['64GB', '128GB', '256GB', '512GB']
          .map((storage) => Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 6, top: 12),
                child: Container(
                    height: 50,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFe5e7eb))),
                    child: Center(
                      child: Text(storage),
                    )),
              ))
          .toList(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFe5e7eb))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.confirmation_number_outlined), Text('Yes')],
            ),
          )),
          SizedBox(width: 20),
          Expanded(
              child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFe5e7eb))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.close_outlined), Text('No')],
            ),
          )),
        ],
      ),
    ),
    DropdownButton<String>(
      items: ['Like New', 'Good', 'Fair', 'Poor']
          .map((condition) => DropdownMenuItem(
                value: condition,
                child: Text(condition),
              ))
          .toList(),
      onChanged: (value) {},
      hint: Text('Select condition'),
    ),
  ];

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
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 100,
            child: Padding(
              padding: EdgeInsets.only(
                  left: padding,
                  right: MediaQuery.of(context).size.width * 0.20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (constraints.maxWidth <= 1600)
                          Image.asset('assets/images/mobile.png', height: 50),
                        Text('Sell my iPhone 13 Pro Max',
                            style: defaultTextStyle.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  if (constraints.maxWidth >= 1600)
                    Positioned(
                      left: constraints.maxWidth * 0.15,
                      bottom: -300,
                      child:
                          Image.asset('assets/images/mobile.png', height: 500),
                    )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Row(
              children: [
                // Top Image Area
                Expanded(flex: 5, child: Container()),
                SizedBox(
                  width: constraints.maxWidth <= 600
                      ? (constraints.maxWidth - 50)
                      : 560,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFe5e7eb))),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          SizedBox(
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return Container(height: 10);
                              },
                              shrinkWrap: true,
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedQuestion =
                                              selectedQuestion == index
                                                  ? null
                                                  : index;
                                        });
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                            backgroundColor: Color(0xffFFC000),
                                            child: Center(
                                              child: Text(index.toString(),
                                                  style:
                                                      defaultTextStyle.copyWith(
                                                          color: Colors.black)),
                                            )),
                                        title: Text(questions[index],
                                            style: defaultTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                    if (selectedQuestion == index)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: answers[index],
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                          if (selectedQuestion == 3) EmailFormWidget(),
                          WeBuyAnyPhoneWidget()
                        ],
                      ),
                    ),
                  ),
                ),
                constraints.maxWidth <= 700
                    ? Container()
                    : SizedBox(width: MediaQuery.of(context).size.width * 0.05)

                // Bottom Section
              ],
            ),
          ),
        ],
      );
    });
  }
}
