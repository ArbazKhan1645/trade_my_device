import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:webuywesell/app/modules/sell_my_phone/controllers/supabase_fetch.dart';

import '../../home/controllers/footer.dart';
import '../models/brands_model.dart';
import '../models/mobile_phones_model.dart';
import '../models/types_model.dart';
import '../pages/phones_area.dart';

class SellMyPhoneController extends GetxController {
  List<Widget> getDashboardViewBodyScreen = [
    const SizedBox(height: 40),
    SellMyIPhoneScreen(),
    MobileFooterPageView(),
  ];

  RxBool isloading = false.obs;
  setIsloading(bool val) {
    isloading.value = val;
  }

  List<BrandsModel> brandsList = [];
  List<TypesModel> typesList = [];

  fetchTypesData() async {
    setIsloading(true);
    await fetchAllBrands(Get.context!);
    await fetchAllTypes(Get.context!);
    await fetchModels();
    filterphoneModels = List.from(phoneModels);
    setIsloading(false);
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
