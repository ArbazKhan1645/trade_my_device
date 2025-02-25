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
    return GetBuilder<DeviceInfoController>(
      builder: (controller) {
        return LayoutBuilder(builder: (context, constraints) {
          double padding = constraints.maxWidth >= 1200
              ? 150.0
              : constraints.maxWidth >= 800
                  ? 50.0
                  : 20.0;

          final phone = controller.phonecurrent;
          final String image = phone?.image ?? 'assets/images/mobile.png';
          final String phoneName = phone?.name ?? 'N/A';
          final List<dynamic> questions = phone?.questions ?? [];

          return Column(
            children: [
              // Top Header
              Container(
                height: 100,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: padding,
                      right: MediaQuery.of(context).size.width * 0.20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (constraints.maxWidth <= 1200)
                        Image.network(image, height: 50),
                      const SizedBox(width: 20),
                      Text(
                        phoneName,
                        style: defaultTextStyle.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Main Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Image (Desktop View)
                    if (constraints.maxWidth >= 1200)
                      Expanded(
                        flex: 5,
                        child: Image.network(image,
                            height: 400, fit: BoxFit.contain),
                      ),

                    // Right Content
                    SizedBox(
                      width: constraints.maxWidth <= 600
                          ? constraints.maxWidth - 50
                          : 560,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFe5e7eb)),
                        ),
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Questions List
                            if (questions.isNotEmpty)
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemCount: questions.length,
                                itemBuilder: (context, index) {
                                  final question = questions[index];
                                  final questionId = controller
                                      .getQuestionId(question['question']);
                                  final String answer =
                                      controller.answers[questionId] ?? '';

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (index <=
                                              controller
                                                  .selectedQuestion.value) {
                                            controller.selectedQuestion.value =
                                                index;
                                          }
                                        },
                                        child: ListTile(
                                          trailing: Text(answer),
                                          leading: CircleAvatar(
                                            backgroundColor: index <=
                                                    controller
                                                        .selectedQuestion.value
                                                ? const Color(0xffFFC000)
                                                : Colors.grey.shade300,
                                            child: Center(
                                              child: Text(
                                                (index + 1).toString(),
                                                style:
                                                    defaultTextStyle.copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            question['question'],
                                            style: defaultTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      if (controller.selectedQuestion.value ==
                                          index)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: _buildAnswerOptions(question),
                                        ),
                                    ],
                                  );
                                },
                              ),

                            // Email Form (Only when all questions are answered)
                            if (controller.selectedQuestion.value ==
                                questions.length)
                              EmailFormWidget(),

                            // "We Buy Any Phone" Widget
                            WeBuyAnyPhoneWidget(),
                          ],
                        ),
                      ),
                    ),

                    if (constraints.maxWidth > 700)
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
