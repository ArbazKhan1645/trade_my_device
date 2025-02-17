// order_screen.dart
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/thems/theme.dart';
import '../../../core/widgets/base.dart';
import '../controllers/profile_screen_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final controller = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return CommonBaseBodyScreen(
      screens: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: 120,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Order History',
                      style: defaultTextStyle.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
        ),
        _buildOrdersList(),
      ],
    );
  }

  Widget _buildSidebar() {
    final filters = [
      'Current Orders',
      'Pending Orders',
      'Older Orders',
      'Refund Orders'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filters
          .map((filter) => Obx(() {
                final isSelected = controller.selectedFilter.value == filter;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: InkWell(
                    onTap: () => controller.changeFilter(filter),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.black87,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }))
          .toList(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        SizedBox(width: 16),
        Text(
          'Order History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LinearProgressIndicator());
      }

      if (controller.orders.isEmpty) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text('No orders found'),
        ));
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.orders.length,
        itemBuilder: (context, index) {
          final order = controller.orders[index];
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Card(
              elevation: 1,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (order.models != null)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(order.models!.first.image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order No: ${order.orderNumber}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '£${(order.models?.length ?? 0) * 329}',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Placed On: ${order.createdAt}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(order.models!.first.name.toString()),
                          Text(order.models!.last.name.toString()),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
