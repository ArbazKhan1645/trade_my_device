// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/core/utils/thems/theme.dart';

import '../../../core/utils/constants/appcolors.dart';
import '../../../data/supabase/supabase_fetch.dart';
import '../../../models/sell_my_phones_model/brands_model.dart';
import '../../../models/sell_my_phones_model/mobile_phones_model.dart';
import '../../../models/sell_my_phones_model/types_model.dart';
import '../widgets/phone_categories_sell.dart';
import '../widgets/footer_widget.dart';
import '../widgets/main_banner_header_widget.dart';

class HomeController extends GetxController {
  List<Widget> getDashboardViewBodyScreen = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          child: SizedBox(
              height: 80,
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth >= 700) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const FeatureItem(
                        icon: Icons.monetization_on_outlined,
                        text: 'We pay more than networks',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      const FeatureItem(
                        icon: Icons.account_balance_outlined,
                        text: 'Fast payment to your bank',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      const FeatureItem(
                        icon: Icons.phone_iphone_outlined,
                        text: 'Send your device to us for free',
                      ),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FeatureItemMobile(
                      icon: Icons.monetization_on_outlined,
                      text: 'We pay more than networks',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const FeatureItemMobile(
                      icon: Icons.account_balance_outlined,
                      text: 'Fast payment to your bank',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const FeatureItemMobile(
                      icon: Icons.phone_iphone_outlined,
                      text: 'Send your device to us for free',
                    ),
                  ],
                );
              })),
        ),
        const MainHeaderwidgetSection(),
        // PopularBrandsWidget(),
        const SellPhoneByCategoryScreen(),
        FooterPageViewWidget(),
        // const SellSmartDevicesScreen(),
        // const SizedBox(height: 50),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Image.asset(
        //         'assets/images/ph1.png', // Replace with a valid asset path
        //       ),
        //     ),
        //     const SizedBox(width: 16),
        //     const Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Join thousands of satisfied customers',
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.w400,
        //               color: Colors.grey,
        //             ),
        //           ),
        //           SizedBox(height: 8),
        //           Text(
        //             'We buy a phone every minute!',
        //             style: TextStyle(
        //               fontSize: 24,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           ),
        //           SizedBox(height: 8),
        //           Text(
        //             'As the largest independent recycler in the UK, you can sell with confidence. Join thousands of satisfied customers today!',
        //             style: TextStyle(
        //               fontSize: 14,
        //               color: Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 50),
        // MyAppMobile(),
        // MyAppguide(),
        // const SizedBox(height: 100)
      ],
    ),
  ];

  RxBool isloading = false.obs;
  setIsloading(bool val) {
    isloading.value = val;
  }

  List<BrandsModel> brandsList = [];
  List<TypesModel> typesList = [];

  fetchTypesData() async {
    try {
      setIsloading(true);
      await fetchAllBrands(Get.context!);
      await fetchAllTypes(Get.context!);
      await fetchModels();
      filterphoneModels = List.from(phoneModels);

      setIsloading(false);
    } on Exception catch (e) {
      setIsloading(false);
    }
  }

  String brandName(int id) {
    var brand = brandsList.where((e) => e.id == id).firstOrNull;
    if (brand != null) {
      return brand.name.toString();
    }
    return 'N/A';
  }

  String typeName(int id) {
    var type = typesList.where((e) => e.id == id).firstOrNull;
    if (type != null) {
      return type.name.toString();
    }
    return 'N/A';
  }

  fetchAllTypes(BuildContext context) async {
    var fetchData = await SupabaseQueryBuilder.get<TypesModel>(
        fromJson: TypesModel.fromJson,
        tablename: 'device_types',
        context: context);
    if (fetchData is List<TypesModel>) {
      typesList = fetchData;
      for (var e in typesList) {
        typesOptions[e.name.toString()] = false;
      }
    } else {
      typesList = [];
      addErrorToErrorList(
          fetchData: fetchData,
          errorType: 'Failed To Fetch all Locations Data, Error : $fetchData');
    }
    update();
  }

  void toggleSelection(String category, String option) {
    if (category == 'Brand') {
      brandOptions[option] = !(brandOptions[option] ?? false);
    } else if (category == 'Type') {
      typesOptions[option] = !(typesOptions[option] ?? false);
    }

    filterPhoneModelsFunctio();

    update();
  }

  List<String> getSelectedOptions(String category) {
    if (category == 'Brand') {
      return brandOptions.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
    } else if (category == 'Type') {
      return typesOptions.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
    }
    return [];
  }

  Map<String, bool> brandOptions = {};
  final Map<String, bool> typesOptions = {};

  fetchAllBrands(BuildContext context) async {
    var fetchData = await SupabaseQueryBuilder.get<BrandsModel>(
        fromJson: BrandsModel.fromJson, tablename: 'brands', context: context);
    if (fetchData is List<BrandsModel>) {
      brandsList = fetchData;
      for (var e in brandsList) {
        brandOptions[e.name.toString()] = false;
      }
    } else {
      brandsList = [];
      addErrorToErrorList(
          fetchData: fetchData,
          errorType: 'Failed To Fetch Countries Data, Error : $fetchData');
    }
    refreshUpdate();
  }

  refreshUpdate() {
    update();
  }

  List<Map<String, dynamic>> errorListFetchingData = [];
  ScrollController scrollController = ScrollController();
  void addErrorToErrorList(
      {required var fetchData, required String errorType}) {
    if (fetchData is String) {
      var existingError = errorListFetchingData
          .where((element) =>
              element.containsKey(errorType) && element[errorType] == fetchData)
          .firstOrNull;
      if (existingError != null) {
        errorListFetchingData.remove(existingError);
      }
      errorListFetchingData.add({errorType: fetchData});
    }
  }

  RxList<MobilePhonesModel> phoneModels = <MobilePhonesModel>[].obs;
  List<MobilePhonesModel> filterphoneModels = <MobilePhonesModel>[];

  Future fetchModels() async {
    try {
      var fetchData = await SupabaseQueryBuilder.get<MobilePhonesModel>(
          fromJson: MobilePhonesModel.fromJson,
          tablename: 'phones_models',
          context: Get.context!);

      if (fetchData is List<MobilePhonesModel>) {
        phoneModels.value = fetchData;

        phoneModels.sort((a, b) => DateTime.parse(b.createdAt.toString())
            .compareTo(DateTime.parse(a.createdAt.toString())));
      } else {
        addErrorToErrorList(
            fetchData: fetchData,
            errorType: 'Failed To Fetch models, Error : $fetchData');
      }
    } on Exception catch (e) {
      addErrorToErrorList(
          fetchData: e.toString(),
          errorType: 'Unexpected Error To Fetch models, Error : $e');
    }
    update();
  }

  void filterPhoneModelsFunctio() {
    List<String> selectedBrands = getSelectedOptions('Brand');
    List<String> selectedTypes = getSelectedOptions('Type');
    filterphoneModels.clear();

    filterphoneModels = phoneModels.where((phone) {
      bool matchesBrand = selectedBrands.isEmpty ||
          selectedBrands.contains(brandName(phone.brands ?? -1));
      bool matchesType = selectedTypes.isEmpty ||
          selectedTypes.contains(typeName(phone.type ?? -1));
      return matchesBrand && matchesType;
    }).toList();

    update();
  }

  @override
  void onInit() {
    fetchTypesData();
    super.onInit();
  }
}

class FeatureItemMobile extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItemMobile({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Icon(icon, color: AppColors.primarycolor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: defaultTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w400)),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItem({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primarycolor, size: 28),
          const SizedBox(width: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
