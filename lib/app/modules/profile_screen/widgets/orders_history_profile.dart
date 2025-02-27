// order_screen.dart
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/models/order_model/order_model.dart';
import 'package:trademydevice/app/modules/home/widgets/footer_widget.dart';
import 'package:trademydevice/app/modules/profile_screen/widgets/order_track_page.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/base.dart';
import '../controllers/profile_screen_controller.dart';

class OrderHistoryScreenProfile extends StatefulWidget {
  const OrderHistoryScreenProfile({super.key});

  @override
  State<OrderHistoryScreenProfile> createState() =>
      _OrderHistoryScreenProfileState();
}

class _OrderHistoryScreenProfileState extends State<OrderHistoryScreenProfile> {
  final ProfileScreenController controller =
      Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(
      screens: [
        const SizedBox(height: 20),
        _buildHeader(),
        const SizedBox(height: 20),
        _buildContent(),
        const SizedBox(height: 200),
        const FooterPageViewWidget(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: 120,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.selectedOrder != null)
                IconButton(
                  onPressed: _onBackPressed,
                  icon: const Icon(Icons.arrow_back_ios, size: 40),
                ),
              Text(
                controller.selectedOrder != null
                    ? 'Order Details'
                    : 'Order History',
                style: defaultTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return controller.selectedOrder == null
        ? _buildOrdersList()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OrderTrackingPage(),
          );
  }

  Widget _buildOrdersList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: LinearProgressIndicator());
      }

      if (controller.orders.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text('No orders found'),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.orders.length,
        itemBuilder: (context, index) {
          final order = controller.orders[index];
          return _buildOrderItem(order);
        },
      );
    });
  }

  Widget _buildOrderItem(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (order.models != null && order.models!.isNotEmpty)
                _buildOrderImage(order.models!.first.image.toString()),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderHeader(order),
                    const SizedBox(height: 8),
                    _buildOrderDate(order.createdAt ?? DateTime.now()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderImage(String imageUrl) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildOrderHeader(OrderModel order) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Order No: ${order.orderNumber} - ${order.id}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () => _onViewOrderStatusPressed(order),
          child: const Text(
            'View Order Status',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDate(DateTime date) {
    return Text(
      'Placed On: ${formatOrderDate(date)}',
      style: const TextStyle(color: Colors.grey),
    );
  }

  void _onBackPressed() {
    controller.resetBrowserURL();
    controller.selectedOrder = null;
    setState(() {});
  }

  void _onViewOrderStatusPressed(OrderModel order) {
    controller.selectedOrder = order;
    controller
        .updateBrowserURL(controller.selectedOrder?.id.toString() ?? '-1');
    setState(() {});
  }
}

String formatOrderDate(DateTime date) {
  return DateFormat('h:mm a dd MMMM yyyy').format(date);
}
