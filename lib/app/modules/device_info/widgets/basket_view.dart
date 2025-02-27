// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/routes/app_pages.dart';
import 'package:trademydevice/app/services/app/app_service.dart';
import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/base.dart';
import '../../../core/dialogs/add_imei_dialog.dart';
import '../../../models/sell_my_phones_model/mobile_phones_model.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late Future<List<MobilePhonesModel>> _phonesFuture;

  @override
  void initState() {
    super.initState();
    _phonesFuture = _fetchPhones();
  }

  Future<List<MobilePhonesModel>> _fetchPhones() async {
    final List<String> storedList = AppService.instance.sharedPreferences
            .getStringList('currentPhoneList') ??
        [];
    return storedList
        .map((item) => MobilePhonesModel.fromJson(jsonDecode(item)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(
      screens: [
        LayoutBuilder(
          builder: (context, constraints) {
            final double padding = _calculatePadding(constraints.maxWidth);
            return FutureBuilder<List<MobilePhonesModel>>(
              future: _phonesFuture,
              builder: (context, snapshot) {
                final phonesList = snapshot.data ?? [];
                return Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: _buildMainContent(context, phonesList),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  double _calculatePadding(double maxWidth) {
    if (maxWidth >= 1200) return 150.0;
    if (maxWidth >= 800) return 50.0;
    return 20.0;
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Here is what you are selling',
            style: defaultTextStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(
      BuildContext context, List<MobilePhonesModel> phonesList) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth <= 600;
        return SingleChildScrollView(
          child: isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPhoneList(context, phonesList),
                    const SizedBox(height: 32),
                    _buildPaymentSection(phonesList),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildPhoneList(context, phonesList)),
                    const SizedBox(width: 32),
                    Expanded(child: _buildPaymentSection(phonesList)),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildPhoneList(
      BuildContext context, List<MobilePhonesModel> phonesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: phonesList.length,
          itemBuilder: (context, index) {
            final model = phonesList[index];
            return _buildPhoneItem(context, model, index, phonesList);
          },
        ),
        if (phonesList.length < 2) _buildAddAnotherDeviceSection(),
      ],
    );
  }

  Widget _buildPhoneItem(BuildContext context, MobilePhonesModel model,
      int index, List<MobilePhonesModel> phonesList) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          model.image.toString(),
          width: 100,
          height: 100,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              model.imei == null
                  ? TextButton(
                      onPressed: () =>
                          _showAddIMEIDialog(context, index, phonesList),
                      child: const Text(
                        'Add an IMEI',
                        style: TextStyle(color: Colors.amber, fontSize: 14),
                      ),
                    )
                  : Text('IMEI: ${model.imei}'),
              const SizedBox(height: 8),
              ...(model.questions ?? []).map((question) => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              question['question'].toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            question['selected_answer'].toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _removePhone(index, phonesList),
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.amber, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection(List<MobilePhonesModel> phonesList) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'We\'ll pay you',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '£${phonesList.fold<num>(0, (sum, element) => sum + (element.manage_price ?? 0))}.00',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildContinueButton(phonesList),
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

  Widget _buildContinueButton(List<MobilePhonesModel> phonesList) {
    return GestureDetector(
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
    );
  }

  Widget _buildAddAnotherDeviceSection() {
    return Column(
      children: [
        Divider(height: 32, thickness: 1, color: Colors.grey.shade400),
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
                    'Add another device',
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
        Divider(height: 32, thickness: 1, color: Colors.grey.shade400),
      ],
    );
  }

  Future<void> _showAddIMEIDialog(BuildContext context, int index,
      List<MobilePhonesModel> phonesList) async {
    final imei = await showAddIMEIDialog(context);
    if (imei == null) return;

    final updatedModel = phonesList[index].copyWith(imei: imei);
    phonesList[index] = updatedModel;

    final List<String> updatedList =
        phonesList.map((model) => jsonEncode(model)).toList();
    await AppService.instance.sharedPreferences
        .setStringList('currentPhoneList', updatedList);
    setState(() {});
  }

  Future<void> _removePhone(
      int index, List<MobilePhonesModel> phonesList) async {
    phonesList.removeAt(index);
    final List<String> updatedList =
        phonesList.map((model) => jsonEncode(model)).toList();
    await AppService.instance.sharedPreferences
        .setStringList('currentPhoneList', updatedList);
    setState(() {});
  }
}
