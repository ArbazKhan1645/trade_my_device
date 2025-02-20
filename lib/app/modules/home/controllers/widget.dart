import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';
import 'package:webuywesell/app/data/configs/api_configs.dart';
import 'package:webuywesell/app/models/phones_model/imei_model.dart';
import 'package:webuywesell/app/modules/sell_my_phone/models/mobile_phones_model.dart';
import 'package:webuywesell/app/repo/network_repository.dart';

import '../../../routes/app_pages.dart';
import '../../../services/app/app_service.dart';
import '../../sell_my_phone/controllers/supabase_fetch.dart';
import '../widgets/iemei_field.dart';

class DeviceWorthScreen extends StatefulWidget {
  const DeviceWorthScreen({super.key});

  @override
  State<DeviceWorthScreen> createState() => _DeviceWorthScreenState();
}

class _DeviceWorthScreenState extends State<DeviceWorthScreen> {
  TextEditingController controller = TextEditingController();

  var isLoading = false;

  void _search() async {
    String input = controller.text.trim();

    if (input.isEmpty) {
      Get.showSnackbar(
          GetSnackBar(title: 'Error', message: 'Input cannot be empty'));
      return;
    }

    isLoading = true;
    setState(() {});
    try {
      if (_isImei(input)) {
        await _searchByImei(input);
      } else {
        await _searchByText(input);
      }
    } catch (e) {
      Get.showSnackbar(
          GetSnackBar(title: 'Error', message: 'Something went wrong: $e'));
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  bool _isImei(String input) {
    return RegExp(r'^\d{15}$')
        .hasMatch(input); // Validates exactly 15-digit number
  }

  Future<void> _searchByImei(String imei) async {
    try {
      final repository = NetworkRepository();

      final basicImeiCheck = await repository.fetchData<ImeiCheckResponse>(
        url:
            'https://dash.imei.info/api/check/0/?API_KEY=${ApiConfig.api_key}&imei=$imei',
        fromJson: (json) => ImeiCheckResponse.fromJson(json),
      );

      var fetchData = await SupabaseQueryBuilder.get<MobilePhonesModel>(
        fromJson: MobilePhonesModel.fromJson,
        tablename: 'phones_models',
        context: Get.context!,
      );

      if (fetchData is! List<MobilePhonesModel>) {
        throw Exception('Invalid data format received');
      }

      List<MobilePhonesModel> filteredData = fetchData
          .where((model) => model.name
              .toString()
              .toLowerCase()
              .contains(basicImeiCheck.result.model.toString().toLowerCase()))
          .toList();

      if (filteredData.isEmpty) {
        Get.showSnackbar(GetSnackBar(
            title: 'Error',
            message:
                'We dont offer this model "${basicImeiCheck.result.model.toString()}"'));
        return;
      }

      // MobilePhonesModel phone = MobilePhonesModel(
      //     brandName: basicImeiCheck.result.brandName,
      //     name: basicImeiCheck.result.model.toString(),
      //     image:
      //         'https://hnyyuaeeasyhuytscoxk.supabase.co/storage/v1/object/public/mobiles/phones_images/1608026706.huawei-p30-prowebp.webp',
      //     id: basicImeiCheck.id);
      await AppService.instance.sharedPreferences
          .setString('currentPhone', jsonEncode(filteredData.first.toJson()));
      Get.offAllNamed(Routes.DEVICE_INFO);
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
          title: 'Error', message: 'Failed to fetch IMEI data: $e'));
    }
  }

  Future<void> _searchByText(String text) async {
    try {
      var fetchData = await SupabaseQueryBuilder.get<MobilePhonesModel>(
        fromJson: MobilePhonesModel.fromJson,
        tablename: 'phones_models',
        context: Get.context!,
      );

      if (fetchData is! List<MobilePhonesModel>) {
        throw Exception('Invalid data format received');
      }

      List<MobilePhonesModel> filteredData = fetchData
          .where((model) =>
              model.name.toString().toLowerCase().contains(text.toLowerCase()))
          .toList();

      if (filteredData.isEmpty) {
        Get.showSnackbar(GetSnackBar(
            title: 'Error', message: 'No results found for "$text"'));
        return;
      }

      if (filteredData.length == 1) {
        await AppService.instance.sharedPreferences
            .setString('currentPhone', jsonEncode(filteredData.first.toJson()));
        Get.offAllNamed(Routes.DEVICE_INFO);
      } else {
        print(filteredData.length);
        Get.offAllNamed(Routes.SELL_MY_PHONE,
            arguments: {'brandlist': filteredData});
      }
    } catch (e) {
      Get.showSnackbar(
          GetSnackBar(title: 'Error', message: 'Search failed: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double getPadding(double width) {
        if (width >= 1200) {
          return 150.0; // Large screen
        } else if (width >= 800) {
          return 50.0; // Medium screen
        } else {
          return 20.0; // Small screen
        }
      }

      double padding = getPadding(constraints.maxWidth);
      return AnimatedContainer(
        height: constraints.maxWidth <= 700 ? 400 : 300,
        duration: Duration(milliseconds: 500),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/footer.png'),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Builder(builder: (context) {
              if (constraints.maxWidth <= 700) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
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
                            child: IMEITextField(
                              onIMEIComplete: (imei) {
                                controller.text = imei;
                              }, // Pass the callback
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xffFFC000),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (isLoading) return;
                                _search();
                           
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        'Search',
                                        style: TextStyle(
                                          color: Colors.black,
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Image.asset(
                            'assets/images/phones.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
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
                                child: IMEITextField(
                                  onIMEIComplete: (imei) {
                                    controller.text = imei;
                                  }, // Pass the callback
                                ),
                              ),
                              Container(
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: Color(0xffFFC000),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (isLoading) return;
                                    _search();
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Text(
                                            'Search',
                                            style: TextStyle(
                                              color: Colors.black,
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
                            style:
                                defaultTextStyle.copyWith(color: Colors.white)),
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
              );
            }),
          ),
        ),
      );
    });
  }
}
