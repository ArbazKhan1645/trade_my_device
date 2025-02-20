// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/routes/app_pages.dart';
import 'package:webuywesell/app/services/app/app_service.dart';
import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/base.dart';
import '../../sell_my_phone/dialog.dart';
import '../../sell_my_phone/models/mobile_phones_model.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  void initState() {
    fetchPhone();
    super.initState();
  }

  List<MobilePhonesModel> getPhoneList() {
    final List<String> storedList = AppService.instance.sharedPreferences
            .getStringList('currentPhoneList') ??
        [];
    return (storedList
            .map((item) => jsonDecode(item) as Map<String, dynamic>)
            .toList())
        .map((w) => MobilePhonesModel.fromJson(w))
        .toList();
  }

  MobilePhonesModel? phonecurrent;
  List<MobilePhonesModel?> phonesList = [];
  fetchPhone() {
    phonesList = getPhoneList();
    setState(() {});
  }

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
          Text(
            '£${phonesList.fold<num>(0, (sum, element) => sum + (element?.manage_price ?? 0))}.00',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              if (phonesList.isEmpty) return;
              Get.offAllNamed(Routes.CHECKOUT);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: phonesList.isEmpty ? Colors.grey.shade300 : Colors.amber,
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

  Widget buildFirstSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
            separatorBuilder: (context, index) {
              return Container(height: 10);
            },
            itemCount: phonesList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              MobilePhonesModel? model = phonesList[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    model!.image.toString(),
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      model.imei == null
                          ? TextButton(
                              onPressed: () async {
                                await showAddIMEIDialog(context)
                                    .then((value) async {
                                  if (value == null) return;
                                  var models = model.copyWith(imei: value);
                                  phonesList.removeAt(index);
                                  phonesList.add(models);

                                  final List<String> existingList = [];
                                  for (var w in phonesList) {
                                    existingList.add(jsonEncode(w));
                                  }
                                  await AppService.instance.sharedPreferences
                                      .setStringList(
                                          'currentPhoneList', existingList);
                                  setState(() {});
                                });
                              },
                              child: const Text(
                                'Add an IMEI',
                                style: TextStyle(
                                    color: Colors.amber, fontSize: 14),
                              ),
                            )
                          : Text('Imei: ${model.imei.toString()}'),
                      const SizedBox(height: 16),
                      Text('Power: ${model.isTurnOn == true ? 'On' : 'Off'}'),
                      Text(
                          'Cracked:   ${model.isCracked == true ? 'Yes' : 'No'}'),
                      Text(
                          'Network:   ${model.networkIsUnlocked == true ? 'unlocked' : 'Locked'}'),
                      Text('Storage:   ${model.storage ?? 'N/A'}'),
                      Text('Condition: Good'),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () async {
                          phonesList.removeAt(index);

                          final List<String> existingList = [];
                          for (var w in phonesList) {
                            existingList.add(jsonEncode(w));
                          }
                          await AppService.instance.sharedPreferences
                              .setStringList('currentPhoneList', existingList);
                          setState(() {});
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.amber, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
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
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.SELL_MY_PHONE);
                    },
                    child: const Text(
                      'Add another device',
                      style: TextStyle(color: Colors.black, fontSize: 14),
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
}
