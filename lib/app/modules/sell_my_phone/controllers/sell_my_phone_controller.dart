// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trademydevice/app/data/supabase/supabase_fetch.dart';

import '../../home/widgets/footer_widget.dart';
import '../../../models/sell_my_phones_model/brands_model.dart';
import '../../../models/sell_my_phones_model/mobile_phones_model.dart';
import '../../../models/sell_my_phones_model/types_model.dart';
import '../pages/phones_area.dart';

class SellMyPhoneController extends GetxController {
  List<Widget> getDashboardViewBodyScreen = [
    const SizedBox(height: 40),
    SellMyIPhoneScreen(),
    FooterPageViewWidget(),
  ];

  RxBool isloading = false.obs;
  setIsloading(bool val) {
    isloading.value = val;
  }

  List<BrandsModel> brandsList = [];
  List<TypesModel> typesList = [];

  void fetchArgyements() {
    if (Get.arguments == null) return;

    String? brand = Get.arguments?['brand'] as String?;
    if (brand == null) return;

    toggleSelection('Brand', brand);
  }

  void fetchListArgyements() {
    if (Get.arguments == null) return;

    String? brand = Get.arguments?['brand'] as String?;
    if (brand == null) return;

    toggleSelection('Brand', brand);
  }

  Future<void> fetchTypesData() async {
    try {
      setIsloading(true);
      final context = Get.context;
      if (context == null) {
        setIsloading(false);
        return;
      }

      if (context.mounted) {
        await fetchAllBrands(context);
      }
      if (context.mounted) {
        await fetchAllTypes(context);
      }
      if (context.mounted) {
        await fetchModels();
      }

      filterphoneModels = List.from(phoneModels);

      fetchArgyements();
      fetchListArguements();

      setIsloading(false);
    } catch (e, stacktrace) {
      setIsloading(false);
      debugPrint('Error in fetchTypesData: $e\n$stacktrace');
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

  void fetchListArguements() {
    final args = Get.arguments;
    if (args == null || args['brandlist'] == null) return;

    List<MobilePhonesModel> phones =
        (args['brandlist'] as List<dynamic>?)?.cast<MobilePhonesModel>() ?? [];

    if (phones.isEmpty) return;

    for (var phone in phones) {
      var newBrand = brandsList.firstWhere(
        (e) => e.id == phone.brands,
        orElse: () => BrandsModel(id: -0, name: ''),
      );

      if (newBrand.id != -0) {
        brandOptions[newBrand.name.toString()] = true;
      }
    }

    filterPhoneModelsFunctio();
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
