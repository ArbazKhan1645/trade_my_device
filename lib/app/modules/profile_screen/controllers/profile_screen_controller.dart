import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../models/users_model.dart/customer_models.dart';
import '../../../services/auth/auth_service.dart';
import '../model/order_model.dart';
import 'dart:html' as html;

class ProfileScreenController extends GetxController {
  final orders = <OrderModel>[].obs;
  final isLoading = true.obs;
  final selectedFilter = 'Current Orders'.obs;

  @override
  void onInit() {
    super.onInit();

    fetchOrders();

    // subscribeToOrders();
  }

  OrderModel? selectedOrder;
  setSelectedOrder(OrderModel? order) {
    selectedOrder = order;
    update();
  }

  void fetchOrders() async {
    try {
      isLoading.value = true;
      final response = await supbaseClient
          .from('orders')
          .select()
          .eq('customer_id', isloginAuthService!.id!);

      orders.value = List<OrderModel>.from(
          response.map((json) => OrderModel.fromJson(json)));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    } finally {
      fetchupdatedUrls();
      isLoading.value = false;
    }
  }

  CustomerModel? get isloginAuthService {
    return AuthService.instance.authCustomer;
  }

  void subscribeToOrders() {
    supbaseClient.from('orders').stream(primaryKey: ['order_id']).listen(
        (List<Map<String, dynamic>> data) {
      final newOrders = data.map((json) => OrderModel.fromJson(json)).toList();
      orders.value = newOrders
          .where((e) => e.customerId == isloginAuthService!.id!)
          .toList();
    });
  }

  String getStatusFilter() {
    switch (selectedFilter.value) {
      case 'Current Orders':
        return 'current';
      case 'Pending Orders':
        return 'pending';
      case 'Older Orders':
        return 'completed';
      case 'Refund Orders':
        return 'refund';
      default:
        return 'current';
    }
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    fetchOrders();
  }

  void updateBrowserURL(String id) {
    if (id == '-1') return;
    final queryParams = <String, String>{};
    queryParams['id'] = id;

    final newUrl = Uri(
      path: '/profile-screen/orders',
      queryParameters: queryParams,
    ).toString();

    html.window.history.pushState(null, '', newUrl);
  }

  void resetBrowserURL() {
    final newUrl = Uri(
      path: '/profile-screen/orders',
    ).toString();

    html.window.history.pushState(null, '', newUrl);
  }

  fetchupdatedUrls() {
    final uri = Uri.parse(Get.currentRoute);
    _parseQueryParameters(uri.queryParameters);
  }

  void _parseQueryParameters(Map<String, String> params) {
    String? id = params['id'];
    String? offerrequest = params['offerrequest'];
    if (id != null) {
      selectedOrder =
          orders.where((ele) => ele.id.toString() == id).firstOrNull;
      if (selectedOrder == null) {
        resetBrowserURL();
      } else {}

      update();
    }
  }
}
