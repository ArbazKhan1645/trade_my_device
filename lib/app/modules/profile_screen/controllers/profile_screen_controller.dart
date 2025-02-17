import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../models/users_model.dart/customer_models.dart';
import '../../../services/auth/auth_service.dart';
import '../model/order_model.dart';

class ProfileScreenController extends GetxController {
  final orders = <OrderModel>[].obs;
  final isLoading = true.obs;
  final selectedFilter = 'Current Orders'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    subscribeToOrders();
  }

  void fetchOrders() async {
    try {
      isLoading.value = true;
      final response = await supbaseClient
          .from('orders')
          .select()
          .eq('customer_id', isloginAuthService!.id!);

      orders.value = response.map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    } finally {
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
}
