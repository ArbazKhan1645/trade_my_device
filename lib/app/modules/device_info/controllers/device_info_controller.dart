// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/models/users_model.dart/customer_models.dart';
import 'package:webuywesell/app/routes/app_pages.dart';
import 'package:webuywesell/app/services/app/app_service.dart';
import 'package:webuywesell/app/services/auth/auth_service.dart';
import '../../home/controllers/footer.dart';
import '../../sell_my_phone/models/mobile_phones_model.dart';
import '../pages/section.dart';
import '../../../../main.dart';

// class DeviceInfoController extends GetxController {
//   // Constants
//   static const _validStorageOptions = {
//     '64gb',
//     '128gb',
//     '256gb',
//     '512gb',
//     '32gb',
//     '1tb',
//     '2tb',
//     '4tb'
//   };
//   static const _validPowerStates = {'on', 'off', 'yes', 'no'};
//   static const _validNetworkStates = {
//     'locked',
//     'unlocked',
//     'on',
//     'off',
//     'yes',
//     'no'
//   };
//   static const _validCrackStates = {'on', 'off', 'yes', 'no'};
//   static const _validconditionsStates = {'new', 'good', 'fair', 'poor'};

//   // State variables
//   final RxString errorMessage = ''.obs;
//   final RxBool isLoading = false.obs;
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();

//   // Device state
//   final RxString power = ''.obs;
//   final RxString storage = ''.obs;
//   final RxString network = ''.obs;
//   final RxString crack = ''.obs;
//   final RxString condition = ''.obs;
//   final RxString brand = ''.obs;
//   final RxString model = ''.obs;

//   late int? selectedQuestion = 0;
//   MobilePhonesModel? phonecurrent = MobilePhonesModel();
//   ImeiCheckResponse? currentdevice;

//   // Getters
//   String get email => emailController.text.trim();
//   bool get loading => isLoading.value;
//   bool get isloginAuthService => AuthService.instance.islogin;

//   // UI Components
//   List<Widget> get dashboardViewBodyScreen => [
//         const SizedBox(height: 40),
//         DeviceInfoScreen(),
//         const SizedBox(height: 40),
//         MobileFooterPageView(),
//       ];

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeController();
//   }

//   void _initializeController() {
//     parseDeepLink();
//     fetchPhone();
//   }

//   // URL and Navigation Methods
//   void parseDeepLink() {
//     final uri = Uri.parse(Get.currentRoute);
//     _parseQueryParameters(uri.queryParameters);
//     _updateSelectedQuestion();
//     update();
//   }

//   void _parseQueryParameters(Map<String, String> params) {
//     power.value = _validateParameter(params['power'], _validPowerStates);
//     storage.value = _validateParameter(params['storage'], _validStorageOptions);
//     network.value = _validateParameter(params['network'], _validNetworkStates);
//     crack.value = _validateParameter(params['iscrack'], _validCrackStates);
//     condition.value =
//         _validateParameter(params['condition'], _validconditionsStates);
//   }

//   String _validateParameter(String? value, Set<String> validOptions) {
//     return validOptions.contains(value) ? value! : '';
//   }

//   void _updateSelectedQuestion() {
//     selectedQuestion = power.value.isEmpty
//         ? 0
//         : storage.value.isEmpty
//             ? 1
//             : network.value.isEmpty
//                 ? 2
//                 : crack.value.isEmpty
//                     ? 3
//                     : condition.value.isEmpty
//                         ? 4
//                         : 5;
//   }

//   // Phone Data Management
//   void fetchPhone() async {
//     final phoneJson =
//         AppService.instance.sharedPreferences.getString('currentPhone');
//     if (phoneJson == null) return;

//     phonecurrent = MobilePhonesModel.fromJson(jsonDecode(phoneJson));
//     await _updatePhoneState();
//     _updateBrowserURL();
//     update();
//   }

//   _updatePhoneState() {
//     if (_validPowerStates.contains(power.value)) {
//       phonecurrent = phonecurrent!.copyWith(isTurnOn: power.value == 'on');
//     }
//     if (_validStorageOptions.contains(storage.value)) {
//       phonecurrent = phonecurrent!.copyWith(storage: storage.value);
//     }
//     if (_validCrackStates.contains(crack.value)) {
//       phonecurrent = phonecurrent!.copyWith(isCracked: crack.value == 'yes');
//     }
//     if (_validNetworkStates.contains(network.value)) {
//       phonecurrent =
//           phonecurrent!.copyWith(networkIsUnlocked: network.value == 'locked');
//     }
//     if (_validconditionsStates.contains(condition.value)) {
//       phonecurrent = phonecurrent!.copyWith(condition: condition.value);
//     }
//   }

//   void updateURL({
//     String? newPower,
//     String? newStorage,
//     String? newnetwork,
//     String? newcrack,
//     String? newcondition,
//   }) {
//     _updateStateValues(
//       newPower: newPower,
//       newStorage: newStorage,
//       newnetwork: newnetwork,
//       newcrack: newcrack,
//       newcondition: newcondition,
//     );
//     _updateBrowserURL();
//     update();
//   }

//   void _updateStateValues({
//     String? newPower,
//     String? newStorage,
//     String? newnetwork,
//     String? newcrack,
//     String? newcondition,
//   }) {
//     if (newPower != null) power.value = newPower;
//     if (newStorage != null) storage.value = newStorage;
//     if (newnetwork != null) network.value = newnetwork;
//     if (newcrack != null) crack.value = newcrack;
//     if (newcondition != null) condition.value = newcondition;
//   }

//   void _updateBrowserURL() {
//     final queryParams = <String, String>{};
//     if (power.value.isNotEmpty) queryParams['power'] = power.value;
//     if (storage.value.isNotEmpty) queryParams['storage'] = storage.value;
//     if (network.value.isNotEmpty) queryParams['network'] = network.value;
//     if (crack.value.isNotEmpty) queryParams['iscrack'] = crack.value;
//     if (condition.value.isNotEmpty) queryParams['condition'] = condition.value;

//     final formattedName = phonecurrent!.name.toString().replaceAll(' ', '-');
//     final newUrl = Uri(
//       path: '/device-info/$formattedName',
//       queryParameters: queryParams,
//     ).toString();

//     html.window.history.pushState(null, '', newUrl);
//   }

//   // Account Management
//   Future<void> handleAccountCreation() async {
//     try {
//       if (isloginAuthService) {
//         await _saveCurrentPhone();
//         Get.offAllNamed(Routes.Payment);
//         return;
//       }
//       // if (_validateAccountCreation()) return;

//       setisLoading(true);

//       await _createNewAccount();
//       print('object khan');
//     } catch (e) {
//       setErrorMessage('Error: ${e.toString()}');
//     } finally {
//       setisLoading(false);
//       update();
//     }
//   }

//   bool _validateAccountCreation() {
//     return formKey.currentState?.validate() ?? false;
//   }

//   Future<void> _saveCurrentPhone() async {
//     await addPhoneToList(phonecurrent!.toJson());
//   }

//   Future<void> addPhoneToList(Map<String, dynamic> phone) async {
//     final List<String> existingList = AppService.instance.sharedPreferences
//             .getStringList('currentPhoneList') ??
//         [];
//     existingList.add(jsonEncode(phone));
//     await AppService.instance.sharedPreferences
//         .setStringList('currentPhoneList', existingList);
//   }

//   Future<void> _createNewAccount() async {
//     final authResponse = await supbaseClient.auth.signUp(
//       email: email,
//       password: 'password',
//     );

//     if (authResponse.user == null) {
//       setErrorMessage('Something went wrong, please try again');
//       return;
//     }

//     final userResponse = await _createUserRecord();
//     if (userResponse == null) return;

//     AuthService.instance.saveAuthState(userResponse);
//     await _saveCurrentPhone();
//     Get.offAllNamed(Routes.Payment);
//   }

//   Future<CustomerModel?> _createUserRecord() async {
//     final insertResponse =
//         await supbaseClient.from('users').insert({'email': email}).select();

//     if (insertResponse.isEmpty) {
//       setErrorMessage('Failed to create user, please try again');
//       return null;
//     }

//     return CustomerModel.fromJson(insertResponse[0]);
//   }

//   // Utility Methods
//   void setErrorMessage(String message) => errorMessage.value = message;
//   void setisLoading(bool val) => isLoading.value = val;
// }

class DeviceInfoController extends GetxController {
  void fetchPhone() async {
    final phoneJson =
        AppService.instance.sharedPreferences.getString('currentPhone');
    if (phoneJson == null) return;

    phonecurrent = MobilePhonesModel.fromJson(jsonDecode(phoneJson));

    _updateBrowserURL();
    update();
  }

  void setisLoading(bool val) => isLoading.value = val;
  // Dynamic state variables
  final RxMap<String, String> answers = <String, String>{}.obs;
  final RxInt selectedQuestion = 0.obs;

  // Other existing state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  MobilePhonesModel? phonecurrent = MobilePhonesModel();

  // Getters
  String get email => emailController.text.trim();
  bool get loading => isLoading.value;
  bool get isloginAuthService => AuthService.instance.islogin;

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() {
    parseDeepLink();
    fetchPhone();
  }

  // URL and Navigation Methods
  void parseDeepLink() {
    final uri = Uri.parse(Get.currentRoute);
    _parseQueryParameters(uri.queryParameters);
    _updateSelectedQuestion();
    update();
  }

  void _parseQueryParameters(Map<String, String> params) {
    // Clear existing answers
    answers.clear();

    // Parse each parameter as a question answer
    params.forEach((key, value) {
      if (key != 'brand' && key != 'model') {
        answers[key] = value;
      }
    });
  }

  void _updateSelectedQuestion() {
    if (phonecurrent?.questions == null) return;

    // Find the first unanswered question
    for (int i = 0; i < phonecurrent!.questions!.length; i++) {
      final question = phonecurrent!.questions![i];
      final questionId = getQuestionId(question['question']);

      if (!answers.containsKey(questionId)) {
        selectedQuestion.value = i;
        return;
      }
    }

    // If all questions are answered, set to last question + 1
    selectedQuestion.value = phonecurrent!.questions!.length;
  }

  // Helper method to generate consistent question IDs
  String getQuestionId(String question) {
    return question.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
  }

  void updateAnswer(
      Map<String, dynamic> question, Map<String, dynamic> option) {
    final questionId = getQuestionId(question['question']);
    final answer = option['answer'].toString().toLowerCase();

    // Update the answer
    answers[questionId] = answer;

    // Update phone current based on the answer
    _updatePhoneState(question, option);

    // Move to next question
    if (selectedQuestion.value < phonecurrent!.questions!.length) {
      selectedQuestion.value++;
    }

    // Update URL
    _updateBrowserURL();
    update();
  }

  void _updatePhoneState(
      Map<String, dynamic> question, Map<String, dynamic> option) {
    final questionText = question['question'];
    final answer = option['answer'].toString().toLowerCase();
    final priceAdjustment = option['price_adjustment'] as num;

    // Update specific phone properties based on the question
    switch (questionText) {
      case 'Does your Phone turned on?':
        phonecurrent =
            phonecurrent!.copyWith(isTurnOn: answer == 'yes' ? true : false);
        break;
      case 'What storage capacity is it?':
        phonecurrent = phonecurrent!.copyWith(storage: answer);
        break;
      // Add other cases as needed
    }

    // Update price
    num newPrice;
    if (phonecurrent?.manage_price != null) {
      newPrice = phonecurrent!.manage_price! + priceAdjustment;
    } else {
      newPrice = phonecurrent!.base_price! + priceAdjustment;
    }
    phonecurrent = phonecurrent!.copyWith(manage_price: newPrice);
  }

  void _updateBrowserURL() {
    final queryParams = <String, String>{};

    // Add all answers to query parameters
    answers.forEach((key, value) {
      queryParams[key] = value;
    });

    final formattedName = phonecurrent!.name.toString().replaceAll(' ', '-');
    final newUrl = Uri(
      path: '/device-info/$formattedName',
      queryParameters: queryParams,
    ).toString();

    html.window.history.pushState(null, '', newUrl);
  }

  Future<void> handleAccountCreation() async {
    try {
      if (isloginAuthService) {
        await _saveCurrentPhone();
        Get.offAllNamed(Routes.Payment);
        return;
      }
      // if (_validateAccountCreation()) return;

      setisLoading(true);

      await _createNewAccount();
      print('object khan');
    } catch (e) {
      setErrorMessage('Error: ${e.toString()}');
    } finally {
      setisLoading(false);
      update();
    }
  }

  bool _validateAccountCreation() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> _saveCurrentPhone() async {
    await addPhoneToList(phonecurrent!.toJson());
  }

  Future<void> addPhoneToList(Map<String, dynamic> phone) async {
    final List<String> existingList = AppService.instance.sharedPreferences
            .getStringList('currentPhoneList') ??
        [];
    existingList.add(jsonEncode(phone));
    await AppService.instance.sharedPreferences
        .setStringList('currentPhoneList', existingList);
  }

  Future<void> _createNewAccount() async {
    final authResponse = await supbaseClient.auth.signUp(
      email: email,
      password: 'password',
    );

    if (authResponse.user == null) {
      setErrorMessage('Something went wrong, please try again');
      return;
    }

    final userResponse = await _createUserRecord();
    if (userResponse == null) return;

    AuthService.instance.saveAuthState(userResponse);
    await _saveCurrentPhone();
    Get.offAllNamed(Routes.Payment);
  }

  Future<CustomerModel?> _createUserRecord() async {
    final insertResponse =
        await supbaseClient.from('users').insert({'email': email}).select();

    if (insertResponse.isEmpty) {
      setErrorMessage('Failed to create user, please try again');
      return null;
    }

    return CustomerModel.fromJson(insertResponse[0]);
  }

  void setErrorMessage(String message) => errorMessage.value = message;

  List<Widget> get dashboardViewBodyScreen => [
        const SizedBox(height: 40),
        DeviceInfoScreen(),
        const SizedBox(height: 40),
        MobileFooterPageView(),
      ];
}
