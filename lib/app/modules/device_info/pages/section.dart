// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/modules/device_info/pages/form.dart';

import '../../../core/utils/thems/theme.dart';
import '../../sell_my_phone/models/mobile_phones_model.dart';
import '../controllers/device_info_controller.dart';
import 'faqs.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  var con = Get.find<DeviceInfoController>();
  bool containsAffirmative(String input) {
    final affirmativeWords = [
      'yes',
      'sure',
      'yeah',
      'yead',
      'yup',
      'ok',
      'okay',
      'affirmative',
      'certainly',
      'of course'
    ];
    final normalizedInput = input.toLowerCase();

    return affirmativeWords.any((word) => normalizedInput.contains(word));
  }

  final List<String> questions = [
    'Does your device turn on?',
    'What storage capacity is it?',
    'Is it network locked or unlocked?',
    'Is the front or back cracked?',
    'What condition best describes your device?',
  ];
  late List<String> questions2 = [
    con.power.value.isEmpty
        ? (con.phonecurrent?.isTurnOn.toString() ?? '')
        : con.power.value,
    con.storage.value.isEmpty
        ? (con.phonecurrent?.storage.toString() ?? '')
        : con.storage.value,
    con.network.value.isEmpty
        ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
        : con.network.value,
    con.crack.value.isEmpty
        ? (con.phonecurrent?.isCracked.toString() ?? '')
        : con.crack.value,
    con.condition.value,
  ];
  late List<Widget> answers2 =
      (con.phonecurrent!.questions as List<dynamic>).map((question) {
    final options = question['options'] as List<dynamic>;
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: options.map((option) {
        return InkWell(
          onTap: () {
            if (question['question'] == 'Does your Phone turned on?') {
              con.selectedQuestion = con.selectedQuestion! + 1;
              con.phonecurrent = con.phonecurrent!.copyWith(
                  isTurnOn: containsAffirmative(
                      option['answer'].toString().toLowerCase()));
              con.updateURL(
                  newPower: option['answer'].toString().toLowerCase());
            } else if (question['question'] == 'What storage capacity is it?') {
              con.selectedQuestion = 2;
              con.phonecurrent = con.phonecurrent!
                  .copyWith(storage: option['answer'].toString().toLowerCase());
              con.updateURL(
                  newStorage: option['answer'].toString().toLowerCase());
            } else if (question['question'] ==
                'Is it network locked or unlocked') {
              con.selectedQuestion = 3;
              con.phonecurrent = con.phonecurrent!.copyWith(
                  networkIsUnlocked: containsAffirmative(
                      option['answer'].toString().toLowerCase()));
              con.updateURL(
                  newnetwork: option['answer'].toString().toLowerCase());
            } else if (question['question'] == 'Is the font or back cracked?') {
              con.selectedQuestion = 4;
              con.phonecurrent = con.phonecurrent!.copyWith(
                  isCracked: containsAffirmative(
                      option['answer'].toString().toLowerCase()));
              con.updateURL(
                  newcrack: option['answer'].toString().toLowerCase());
            } else if (question['question'] ==
                'What condition best describe four device?') {
              con.selectedQuestion = 5;
              con.phonecurrent = con.phonecurrent!.copyWith(
                  condition: option['answer'].toString().toLowerCase());
              con.updateURL(
                  newcondition: option['answer'].toString().toLowerCase());
            } else {}

            num priceAdjustment = option['price_adjustment'] as num;
            num newPrice;

            if (con.phonecurrent?.manage_price != null) {
              newPrice = con.phonecurrent!.manage_price! + priceAdjustment;
            } else {
              newPrice = con.phonecurrent!.base_price! + priceAdjustment;
            }
            con.phonecurrent =
                con.phonecurrent!.copyWith(manage_price: newPrice);
            setState(() {
              questions2 = [
                con.power.value.isEmpty
                    ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                    : con.power.value,
                con.storage.value.isEmpty
                    ? (con.phonecurrent?.storage.toString() ?? '')
                    : con.storage.value,
                con.network.value.isEmpty
                    ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
                    : con.network.value,
                con.crack.value.isEmpty
                    ? (con.phonecurrent?.isCracked.toString() ?? '')
                    : con.crack.value,
                con.condition.value,
              ];
            });
          },
          child: Container(
            height: 100,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFe5e7eb))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.confirmation_number_outlined),
                Text(option['answer'])
              ],
            ),
          ),
        );
      }).toList(),
    );
  }).toList();
  late List<Widget> answers = [
    Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                con.selectedQuestion = 1;
                con.phonecurrent = con.phonecurrent!.copyWith(isTurnOn: true);
                con.updateURL(newPower: 'on');
                questions2 = [
                  con.power.value.isEmpty
                      ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                      : con.power.value,
                  con.storage.value.isEmpty
                      ? (con.phonecurrent?.storage.toString() ?? '')
                      : con.storage.value,
                  con.network.value.isEmpty
                      ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
                      : con.network.value,
                  con.crack.value.isEmpty
                      ? (con.phonecurrent?.isCracked.toString() ?? '')
                      : con.crack.value,
                  con.condition.value,
                ];
              });
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFe5e7eb))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.confirmation_number_outlined),
                  Text('Yes')
                ],
              ),
            ),
          )),
          SizedBox(width: 20),
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                con.selectedQuestion = 1;
                con.phonecurrent = con.phonecurrent!.copyWith(isTurnOn: false);
                con.updateURL(newPower: 'off');
                questions2 = [
                  con.power.value.isEmpty
                      ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                      : con.power.value,
                  con.storage.value.isEmpty
                      ? (con.phonecurrent?.storage.toString() ?? '')
                      : con.storage.value,
                  con.network.value.isEmpty
                      ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
                      : con.network.value,
                  con.crack.value.isEmpty
                      ? (con.phonecurrent?.isCracked.toString() ?? '')
                      : con.crack.value,
                  con.condition.value,
                ];
              });
            },
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
            ),
          )),
        ],
      ),
    ),
    Wrap(
      children: ['64GB', '128GB', '256GB', '512GB']
          .map((storage) => Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 6, top: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      con.selectedQuestion = 2;

                      con.phonecurrent =
                          con.phonecurrent!.copyWith(storage: storage);
                      con.updateURL(newStorage: storage);
                      con.update();
                      questions2 = [
                        con.power.value.isEmpty
                            ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                            : con.power.value,
                        con.storage.value.isEmpty
                            ? (con.phonecurrent?.storage.toString() ?? '')
                            : con.storage.value,
                        con.network.value.isEmpty
                            ? (con.phonecurrent?.networkIsUnlocked.toString() ??
                                '')
                            : con.network.value,
                        con.crack.value.isEmpty
                            ? (con.phonecurrent?.isCracked.toString() ?? '')
                            : con.crack.value,
                        con.condition.value,
                      ];
                      print(questions2);
                    });
                  },
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
                ),
              ))
          .toList(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                con.selectedQuestion = 3;
                con.phonecurrent = con.phonecurrent!.copyWith(isTurnOn: true);
                con.updateURL(newnetwork: 'locked');
                questions2 = [
                  con.power.value.isEmpty
                      ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                      : con.power.value,
                  con.storage.value.isEmpty
                      ? (con.phonecurrent?.storage.toString() ?? '')
                      : con.storage.value,
                  con.network.value.isEmpty
                      ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
                      : con.network.value,
                  con.crack.value.isEmpty
                      ? (con.phonecurrent?.isCracked.toString() ?? '')
                      : con.crack.value,
                  con.condition.value,
                ];
              });
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFe5e7eb))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.confirmation_number_outlined),
                  Text('Yes')
                ],
              ),
            ),
          )),
          SizedBox(width: 20),
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                con.selectedQuestion = 3;
                con.phonecurrent = con.phonecurrent!.copyWith(isTurnOn: false);
                con.updateURL(newnetwork: 'unlocked');
                questions2 = [
                  con.power.value.isEmpty
                      ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                      : con.power.value,
                  con.storage.value.isEmpty
                      ? (con.phonecurrent?.storage.toString() ?? '')
                      : con.storage.value,
                  con.network.value.isEmpty
                      ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
                      : con.network.value,
                  con.crack.value.isEmpty
                      ? (con.phonecurrent?.isCracked.toString() ?? '')
                      : con.crack.value,
                  con.condition.value,
                ];
              });
            },
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
            ),
          )),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                con.selectedQuestion = 4;
                con.phonecurrent = con.phonecurrent!.copyWith(isCracked: true);
                con.updateURL(newcrack: 'yes');
                questions2 = [
                  con.power.value.isEmpty
                      ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                      : con.power.value,
                  con.storage.value.isEmpty
                      ? (con.phonecurrent?.storage.toString() ?? '')
                      : con.storage.value,
                  con.network.value.isEmpty
                      ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
                      : con.network.value,
                  con.crack.value.isEmpty
                      ? (con.phonecurrent?.isCracked.toString() ?? '')
                      : con.crack.value,
                  con.condition.value,
                ];
              });
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFe5e7eb))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.confirmation_number_outlined),
                  Text('Yes')
                ],
              ),
            ),
          )),
          SizedBox(width: 20),
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                con.selectedQuestion = 4;
                con.phonecurrent = con.phonecurrent!.copyWith(isCracked: false);
                con.updateURL(newcrack: 'no');
                questions2 = [
                  con.power.value.isEmpty
                      ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                      : con.power.value,
                  con.storage.value.isEmpty
                      ? (con.phonecurrent?.storage.toString() ?? '')
                      : con.storage.value,
                  con.network.value.isEmpty
                      ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
                      : con.network.value,
                  con.crack.value.isEmpty
                      ? (con.phonecurrent?.isCracked.toString() ?? '')
                      : con.crack.value,
                  con.condition.value,
                ];
              });
            },
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
            ),
          )),
        ],
      ),
    ),
    Wrap(
      children: ['New', 'Good', 'Fair', 'Poor']
          .map((value) => Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 6, top: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      con.selectedQuestion = 5;
                      con.phonecurrent =
                          con.phonecurrent!.copyWith(condition: value);
                      con.updateURL(newcondition: value.toLowerCase().trim());
                      questions2 = [
                        con.power.value.isEmpty
                            ? (con.phonecurrent?.isTurnOn.toString() ?? '')
                            : con.power.value,
                        con.storage.value.isEmpty
                            ? (con.phonecurrent?.storage.toString() ?? '')
                            : con.storage.value,
                        con.network.value.isEmpty
                            ? (con.phonecurrent?.networkIsUnlocked.toString() ??
                                '')
                            : con.network.value,
                        con.crack.value.isEmpty
                            ? (con.phonecurrent?.isCracked.toString() ?? '')
                            : con.crack.value,
                        con.condition.value,
                      ];
                    });
                  },
                  child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFe5e7eb))),
                      child: Center(
                        child: Text(value),
                      )),
                ),
              ))
          .toList(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceInfoController>(builder: (controller) {
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
                      child: Builder(builder: (context) {
                        String iphonename = 'N/A';
                        String image = 'assets/images/mobile.png';
                        final args = con.phonecurrent;
                        if (args != null) {
                          MobilePhonesModel phone = args;
                          iphonename = phone.name.toString();
                          image = phone.image.toString();
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (constraints.maxWidth <= 1200)
                              Image.network(image, height: 50),
                            SizedBox(width: 20),
                            Text(iphonename,
                                style: defaultTextStyle.copyWith(
                                    fontSize: 24, fontWeight: FontWeight.w600)),
                          ],
                        );
                      }),
                    ),
                    if (constraints.maxWidth >= 1200)
                      Builder(builder: (context) {
                        String iphonename = 'N/A';
                        String image = 'assets/images/mobile.png';
                        final args = con.phonecurrent;
                        if (args != null) {
                          MobilePhonesModel phone = args;
                          iphonename = phone.name.toString();
                          image = phone.image.toString();
                        }
                        return Positioned(
                          left: constraints.maxWidth >= 1600
                              ? constraints.maxWidth * 0.15
                              : constraints.maxWidth * 0.10,
                          top: -0,
                          child: Image.network(image, height: 400),
                        );
                      })
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (index == con.selectedQuestion ||
                                              index < con.selectedQuestion!) {
                                            setState(() {
                                              con.selectedQuestion =
                                                  con.selectedQuestion == index
                                                      ? null
                                                      : index;
                                            });
                                          } else {
                                            return;
                                          }
                                        },
                                        child: ListTile(
                                          trailing: Text(
                                              questions2[index] == 'null'
                                                  ? ''
                                                  : questions2[index]),
                                          leading: CircleAvatar(
                                              backgroundColor: index ==
                                                          con
                                                              .selectedQuestion ||
                                                      index <
                                                          con.selectedQuestion!
                                                  ? Color(0xffFFC000)
                                                  : Colors.grey.shade300,
                                              child: Center(
                                                child: Text(
                                                    (index + 1).toString(),
                                                    style: defaultTextStyle
                                                        .copyWith(
                                                            color:
                                                                Colors.black)),
                                              )),
                                          title: Text(questions[index],
                                              style: defaultTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ),
                                      if (con.selectedQuestion == index)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: answers2[index],
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            if (con.selectedQuestion == 5) EmailFormWidget(),
                            WeBuyAnyPhoneWidget()
                          ],
                        ),
                      ),
                    ),
                  ),
                  constraints.maxWidth <= 700
                      ? Container()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05)

                  // Bottom Section
                ],
              ),
            ),
          ],
        );
      });
    });
  }
}
