// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:get/get.dart';
import 'package:trademydevice/app/routes/app_pages.dart';

import '../../../../main.dart';
import '../../../models/users_model.dart/customer_models.dart';
import '../../../services/auth/auth_service.dart';
import '../../../models/order_model/order_model.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class ProfileScreenController extends GetxController {
  final orders = <OrderModel>[].obs;
  final isLoading = true.obs;
  final selectedFilter = 'Current Orders'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  OrderModel? selectedOrder;
  setSelectedOrder(OrderModel? order) {
    selectedOrder = order;
    update();
  }

  void fetchOrders() async {
    try {
      if (isloginAuthService == null) {
        final uri = Uri.parse(Get.currentRoute);
        var params = uri.queryParameters;
        final String? id = params['id'];
        final String? offerRequest = params['offerrequest'];

        if (id != null && offerRequest != null) {
          var res = await supbaseClient.from('orders').select().eq('id', id);
          if (res.isEmpty) {
            Get.offAllNamed(Routes.HOME);
            return;
          }

          OrderModel order = OrderModel.fromJson(res.first);
          parseQueryParameters(params, value: offerRequest, order: order);
          Get.offAllNamed(Routes.HOME);
          return;
        } else {
          Get.offAllNamed(Routes.HOME);
          return;
        }
      }
      if (isloginAuthService!.id == null) {
        final uri = Uri.parse(Get.currentRoute);
        var params = uri.queryParameters;
        final String? id = params['id'];
        final String? offerRequest = params['offerrequest'];

        if (id != null && offerRequest != null) {
          var res = await supbaseClient.from('orders').select().eq('id', id);
          if (res.isEmpty) {
            Get.offAllNamed(Routes.HOME);
            return;
          }

          OrderModel order = OrderModel.fromJson(res.first);
          parseQueryParameters(params, value: offerRequest, order: order);
          Get.offAllNamed(Routes.HOME);
          return;
        } else {
          Get.offAllNamed(Routes.HOME);
          return;
        }
      }
      isLoading.value = true;
      final response = await supbaseClient
          .from('orders')
          .select()
          .eq('customer_id', isloginAuthService!.id!);

      orders.value = response.map((json) => OrderModel.fromJson(json)).toList();
      orders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    } finally {
      fetchupdatedUrls();
      isLoading.value = false;
    }
  }

  void subscribeToOrders() {
    supbaseClient
        .from('orders')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      final newOrders = data.map((json) => OrderModel.fromJson(json)).toList();
      newOrders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      orders.value = newOrders
          .where((e) => e.customerId == isloginAuthService!.id!)
          .toList();
    });
  }

  CustomerModel? get isloginAuthService {
    return AuthService.instance.authCustomer;
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

  fetchupdatedUrls({String? value, String? ids}) {
    final uri = Uri.parse(Get.currentRoute);
    parseQueryParameters(uri.queryParameters, value: value, ids: ids);
  }

  void parseQueryParameters(Map<String, String> params,
      {String? value, String? ids, OrderModel? order}) {
    try {
      final String? id = ids ?? params['id'];
      final String? offerRequest = value ?? params['offerrequest'];
      // Early return if no ID provided
      if (id == null || id.isEmpty) {
        resetBrowserURL();
        return;
      }

      // Find order and handle if not found
      selectedOrder =
          order ?? orders.firstWhereOrNull((ele) => ele.id.toString() == id);
      update();
      if (selectedOrder == null) {
        Get.snackbar('Error', 'Order not found');
        resetBrowserURL();
        return;
      }

      // Check for valid counteroffer
      final counteroffer = selectedOrder!.counteroffer;
      if (counteroffer == null || counteroffer.isEmpty) {
        return;
      }

      // Check if counteroffer is already actioned
      final firstCounter = counteroffer.first;
      if (firstCounter['actioned'].toString() != 'false') {
        updateBrowserURL(id);
        return;
      }

      // Convert lists with null safety
      final List<Map<String, dynamic>> counter =
          (selectedOrder!.counteroffer ?? [])
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
      final List<Map<String, dynamic>> timeline =
          (selectedOrder!.timeline ?? [])
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

      // Cache the first counter offer
      final cachedCounter = Map<String, dynamic>.from(counter.first);

      // Handle offer request actions
      switch (offerRequest?.toLowerCase()) {
        case 'accept':
          _handleAcceptOffer(counter, timeline, cachedCounter);
          break;
        case 'reject':
          _handleRejectOffer(counter, timeline, cachedCounter);
          break;
        case null:
          updateBrowserURL(id);
          break;
        default:
          Get.snackbar('Error', 'Invalid offer request type');
          return;
      }

      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while processing the request: ${e.toString()}',
        duration: const Duration(seconds: 5),
      );
      resetBrowserURL();
    }
  }

  void _handleAcceptOffer(
    List<Map<String, dynamic>> counter,
    List<Map<String, dynamic>> timeline,
    Map<String, dynamic> cachedCounter,
  ) {
    try {
      counter.clear();
      counter.add({
        "date": cachedCounter['date'],
        "time": cachedCounter['time'],
        "price": cachedCounter['price'],
        "description": cachedCounter['description'],
        'actioned': 'accepted'
      });

      timeline.add(_createTimelineEntry(
        'You accepted the counter offer of £${counter.first['price']}',
        counter.first['description'],
      ));
      selectedOrder!.counteroffer = counter;
      selectedOrder!.timeline = timeline;

      _updateSupabase(counter: counter, timeline: timeline);
    } catch (e) {
      Get.snackbar('Error', 'Failed to accept offer: ${e.toString()}');
    }
  }

  void _handleRejectOffer(
    List<Map<String, dynamic>> counter,
    List<Map<String, dynamic>> timeline,
    Map<String, dynamic> cachedCounter,
  ) {
    try {
      timeline.add(_createTimelineEntry(
        'You rejected the counter offer of £${counter.first['price']}',
        counter.first['description'],
      ));

      selectedOrder!.counteroffer = null;
      selectedOrder!.timeline = timeline;

      _updateSupabase(counter: null, timeline: timeline);
    } catch (e) {
      Get.snackbar('Error', 'Failed to reject offer: ${e.toString()}');
    }
  }

  Map<String, String> _createTimelineEntry(String status, String description) {
    return {
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "time": DateFormat('HH:mm').format(DateTime.now()),
      "status": status,
      "description": description,
    };
  }

  Future<void> _updateSupabase({
    List<Map<String, dynamic>>? counter,
    required List<Map<String, dynamic>> timeline,
  }) async {
    try {
      await supbaseClient.from('orders').update({
        'counter_offer': counter,
        'timeline': timeline,
      }).eq('id', selectedOrder!.id!);
      updateBrowserURL(selectedOrder!.id.toString());
    } catch (e) {
      Get.snackbar('Error', 'Failed to update database: ${e.toString()}');
      rethrow; // Re-throw to be caught by the main try-catch
    }
  }
}
