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


  Widget _buildAnswerOptions(Map<String, dynamic> question) {
    final options = question['options'] as List<dynamic>;

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: options.map((option) {
        return InkWell(
          onTap: () => con.updateAnswer(question, option),
          child: Container(
            height: 100,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFe5e7eb)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.confirmation_number_outlined),
                Text(option['answer']),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // late List<String> questions2 = [
  //   con.power.value.isEmpty
  //       ? (con.phonecurrent?.isTurnOn.toString() ?? '')
  //       : con.power.value,
  //   con.storage.value.isEmpty
  //       ? (con.phonecurrent?.storage.toString() ?? '')
  //       : con.storage.value,
  //   con.network.value.isEmpty
  //       ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
  //       : con.network.value,
  //   con.crack.value.isEmpty
  //       ? (con.phonecurrent?.isCracked.toString() ?? '')
  //       : con.crack.value,
  //   con.condition.value,
  // ];
  // late List<Widget> answers2 =
  //     (con.phonecurrent!.questions as List<dynamic>).map((question) {
  //   final options = question['options'] as List<dynamic>;
  //   return Wrap(
  //     spacing: 8.0,
  //     runSpacing: 8.0,
  //     children: options.map((option) {
  //       return InkWell(
  //         onTap: () {
  //           if (question['question'] == 'Does your Phone turned on?') {
  //             con.selectedQuestion = con.selectedQuestion! + 1;
  //             con.phonecurrent = con.phonecurrent!.copyWith(
  //                 isTurnOn: containsAffirmative(
  //                     option['answer'].toString().toLowerCase()));
  //             con.updateURL(
  //                 newPower: option['answer'].toString().toLowerCase());
  //           } else if (question['question'] == 'What storage capacity is it?') {
  //             con.selectedQuestion = 2;
  //             con.phonecurrent = con.phonecurrent!
  //                 .copyWith(storage: option['answer'].toString().toLowerCase());
  //             con.updateURL(
  //                 newStorage: option['answer'].toString().toLowerCase());
  //           } else if (question['question'] ==
  //               'Is it network locked or unlocked') {
  //             con.selectedQuestion = 3;
  //             con.phonecurrent = con.phonecurrent!.copyWith(
  //                 networkIsUnlocked: containsAffirmative(
  //                     option['answer'].toString().toLowerCase()));
  //             con.updateURL(
  //                 newnetwork: option['answer'].toString().toLowerCase());
  //           } else if (question['question'] == 'Is the font or back cracked?') {
  //             con.selectedQuestion = 4;
  //             con.phonecurrent = con.phonecurrent!.copyWith(
  //                 isCracked: containsAffirmative(
  //                     option['answer'].toString().toLowerCase()));
  //             con.updateURL(
  //                 newcrack: option['answer'].toString().toLowerCase());
  //           } else if (question['question'] ==
  //               'What condition best describe four device?') {
  //             con.selectedQuestion = 5;
  //             con.phonecurrent = con.phonecurrent!.copyWith(
  //                 condition: option['answer'].toString().toLowerCase());
  //             con.updateURL(
  //                 newcondition: option['answer'].toString().toLowerCase());
  //           } else {}

  //           num priceAdjustment = option['price_adjustment'] as num;
  //           num newPrice;

  //           if (con.phonecurrent?.manage_price != null) {
  //             newPrice = con.phonecurrent!.manage_price! + priceAdjustment;
  //           } else {
  //             newPrice = con.phonecurrent!.base_price! + priceAdjustment;
  //           }
  //           con.phonecurrent =
  //               con.phonecurrent!.copyWith(manage_price: newPrice);
  //           setState(() {
  //             questions2 = [
  //               con.power.value.isEmpty
  //                   ? (con.phonecurrent?.isTurnOn.toString() ?? '')
  //                   : con.power.value,
  //               con.storage.value.isEmpty
  //                   ? (con.phonecurrent?.storage.toString() ?? '')
  //                   : con.storage.value,
  //               con.network.value.isEmpty
  //                   ? (con.phonecurrent?.networkIsUnlocked.toString() ?? '')
  //                   : con.network.value,
  //               con.crack.value.isEmpty
  //                   ? (con.phonecurrent?.isCracked.toString() ?? '')
  //                   : con.crack.value,
  //               con.condition.value,
  //             ];
  //           });
  //         },
  //         child: Container(
  //           height: 100,
  //           width: 200,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(color: Color(0xFFe5e7eb))),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.confirmation_number_outlined),
  //               Text(option['answer'])
  //             ],
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }).toList();

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
                            con.phonecurrent?.questions == null
                                ? const SizedBox()
                                : ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10),
                                      shrinkWrap: true,
                                      itemCount:
                                          con.phonecurrent!.questions!.length,
                                      itemBuilder: (context, index) {
                                        final question =
                                            con.phonecurrent!.questions![index];
                                        final questionId = con.getQuestionId(
                                            question['question']);
                                        final answer =
                                            con.answers[questionId] ?? '';

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (index <=
                                                    con.selectedQuestion
                                                        .value) {
                                                  con.selectedQuestion.value =
                                                      index;
                                                }
                                              },
                                              child: ListTile(
                                                trailing: Text(answer),
                                                leading: CircleAvatar(
                                                  backgroundColor: index <=
                                                          con.selectedQuestion
                                                              .value
                                                      ? const Color(0xffFFC000)
                                                      : Colors.grey.shade300,
                                                  child: Center(
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      style: defaultTextStyle
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                  question['question'],
                                                  style:
                                                      defaultTextStyle.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (con.selectedQuestion.value ==
                                                index)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: _buildAnswerOptions(
                                                    question),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                            // SizedBox(
                            //   child: ListView.separated(
                            //     physics: NeverScrollableScrollPhysics(),
                            //     separatorBuilder: (context, index) {
                            //       return Container(height: 10);
                            //     },
                            //     shrinkWrap: true,
                            //     itemCount: questions.length,
                            //     itemBuilder: (context, index) {
                            //       return Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           GestureDetector(
                            //             onTap: () {
                            //               if (index == con.selectedQuestion ||
                            //                   index < con.selectedQuestion!) {
                            //                 setState(() {
                            //                   con.selectedQuestion =
                            //                       con.selectedQuestion == index
                            //                           ? null
                            //                           : index;
                            //                 });
                            //               } else {
                            //                 return;
                            //               }
                            //             },
                            //             child: ListTile(
                            //               trailing: Text(
                            //                   questions2[index] == 'null'
                            //                       ? ''
                            //                       : questions2[index]),
                            //               leading: CircleAvatar(
                            //                   backgroundColor: index ==
                            //                               con
                            //                                   .selectedQuestion ||
                            //                           index <
                            //                               con.selectedQuestion!
                            //                       ? Color(0xffFFC000)
                            //                       : Colors.grey.shade300,
                            //                   child: Center(
                            //                     child: Text(
                            //                         (index + 1).toString(),
                            //                         style: defaultTextStyle
                            //                             .copyWith(
                            //                                 color:
                            //                                     Colors.black)),
                            //                   )),
                            //               title: Text(questions[index],
                            //                   style: defaultTextStyle.copyWith(
                            //                       fontSize: 14,
                            //                       fontWeight: FontWeight.w400)),
                            //             ),
                            //           ),
                            //           if (con.selectedQuestion == index)
                            //             Padding(
                            //               padding:
                            //                   const EdgeInsets.only(left: 16.0),
                            //               child: answers2[index],
                            //             ),
                            //         ],
                            //       );
                            //     },
                            //   ),
                            // ),
                            // if (con.selectedQuestion == 5) EmailFormWidget(),
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
