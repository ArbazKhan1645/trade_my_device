// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/modules/device_info/widgets/email_input_form.dart';
import '../../../core/utils/thems/theme.dart';
import '../controllers/device_info_controller.dart';
import 'device_info_faqs_section.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  final DeviceInfoController controller = Get.find<DeviceInfoController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceInfoController>(
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final double padding = _calculatePadding(constraints.maxWidth);
            final phone = controller.phonecurrent;
            final String image = phone?.image ?? 'assets/images/mobile.png';
            final String phoneName = phone?.name ?? 'N/A';
            final List<dynamic> questions = phone?.questions ?? [];

            return Column(
              children: [
                _buildTopHeader(
                    context, constraints, padding, image, phoneName),
                const SizedBox(height: 20),
                _buildMainContent(
                    context, constraints, padding, image, questions),
              ],
            );
          },
        );
      },
    );
  }

  double _calculatePadding(double maxWidth) {
    if (maxWidth >= 1200) return 150.0;
    if (maxWidth >= 800) return 50.0;
    return 20.0;
  }

  Widget _buildTopHeader(BuildContext context, BoxConstraints constraints,
      double padding, String image, String phoneName) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.only(
            left: padding, right: MediaQuery.of(context).size.width * 0.20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (constraints.maxWidth <= 1200) Image.network(image, height: 50),
            const SizedBox(width: 20),
            Text(
              phoneName,
              style: defaultTextStyle.copyWith(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, BoxConstraints constraints,
      double padding, String image, List<dynamic> questions) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (constraints.maxWidth >= 1200)
            Expanded(
              flex: 5,
              child: Image.network(image, height: 400, fit: BoxFit.contain),
            ),
          _buildRightContent(constraints, questions),
          if (constraints.maxWidth > 700)
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }

  Widget _buildRightContent(
      BoxConstraints constraints, List<dynamic> questions) {
    return SizedBox(
      width: constraints.maxWidth <= 600 ? constraints.maxWidth - 50 : 560,
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
            if (questions.isNotEmpty) _buildQuestionsList(questions),
            if (controller.selectedQuestion.value == questions.length)
              EmailFormWidget(),
            DeviceInfoFaqsSectionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsList(List<dynamic> questions) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final questionId = controller.getQuestionId(question['question']);
        final String answer = controller.answers[questionId] ?? '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (index <= controller.selectedQuestion.value) {
                  controller.selectedQuestion.value = index;
                }
              },
              child: ListTile(
                trailing: Text(answer),
                leading: CircleAvatar(
                  backgroundColor: index <= controller.selectedQuestion.value
                      ? const Color(0xffFFC000)
                      : Colors.grey.shade300,
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: defaultTextStyle.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                title: Text(
                  question['question'],
                  style: defaultTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            if (controller.selectedQuestion.value == index)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _buildAnswerOptions(question),
              ),
          ],
        );
      },
    );
  }

  Widget _buildAnswerOptions(Map<String, dynamic> question) {
    final options = question['options'] as List<dynamic>;
    return LayoutBuilder(builder: (context, constraints) {
      return Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: options.map((option) {
          return InkWell(
            onTap: () => controller.updateAnswer(question, option),
            child: Container(
              height: 100,
              width: constraints.maxWidth * 0.3,
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
    });
  }
}
