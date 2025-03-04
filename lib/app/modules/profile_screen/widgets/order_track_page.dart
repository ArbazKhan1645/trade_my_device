// ignore_for_file: use_build_context_synchronously, unnecessary_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/modules/profile_screen/controllers/profile_screen_controller.dart';
import 'package:trademydevice/app/modules/profile_screen/widgets/orders_history_profile.dart';
import 'package:trademydevice/app/models/sell_my_phones_model/mobile_phones_model.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final controller = Get.put(ProfileScreenController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildOrderInfo(),
          const SizedBox(height: 16),
          if ((controller.selectedOrder?.counteroffer ?? []).isNotEmpty &&
              controller.selectedOrder?.status == 'In Progress')
            _buildOrdercounterofferStatus(),
          const SizedBox(height: 16),
          if ((controller.selectedOrder?.timeline ?? []).isNotEmpty)
            _buildOrderStatus(),
          const SizedBox(height: 16),
          _buildShipmentDetails(),
          const SizedBox(height: 16),
          _buildModelDetails(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order No: ${controller.selectedOrder?.orderNumber ?? 'N/A'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Order Status: ${controller.selectedOrder?.status ?? 'N/A'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Placed On: ${formatOrderDate(controller.selectedOrder?.createdAt ?? DateTime.now())}',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(width: 8),
                Text(
                  'Order Status Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const Divider(height: 24, color: Colors.grey),
            _buildTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdercounterofferStatus() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(width: 8),
                Text(
                  'Order Counter Offer Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const Divider(height: 24, color: Colors.grey),
            _buildcounterline(),
          ],
        ),
      ),
    );
  }

  Widget _buildcounterline() {
    final List<Map<String, String>> timeline = [];
    for (var status in controller.selectedOrder?.counteroffer ?? []) {
      timeline.add({
        'date': status['date'] ?? '',
        'time': status['time'] ?? '',
        'description': status['description'] ?? '',
        'price': status['price'] ?? '',
        'actioned':
            status['actioned'] == null ? 'false' : status['actioned'].toString()
      });
    }

    return Column(
      children:
          timeline.map((entry) => _buildTimelineTileCounter(entry)).toList(),
    );
  }

  Widget _buildTimeline() {
    final List<Map<String, String>> timeline = [];
    for (var status in controller.selectedOrder?.timeline ?? []) {
      timeline.add({
        'date': status['date'] ?? '',
        'time': status['time'] ?? '',
        'description': status['description'] ?? '',
        'status': status['status'] ?? '',
      });
    }

    return Column(
      children: timeline.map((entry) => _buildTimelineTile(entry)).toList(),
    );
  }

  Widget _buildTimelineTile(Map<String, String> entry) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              Icons.radio_button_unchecked,
              color: Colors.grey,
              size: 20,
            ),
            if (entry['status'] != 'Order Pending')
              Container(
                width: 2,
                height: 40,
                color: Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${entry['date']} ${entry['time']}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(
                    entry['status'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(entry['description'].toString()),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineTileCounter(Map<String, String> entry) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              Icons.radio_button_unchecked,
              color: Colors.grey,
              size: 20,
            ),
            if (entry['status'] != 'Order Pending')
              Container(
                width: 2,
                height: 40,
                color: Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${entry['date']} ${entry['time']}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 4),
              Text(entry['description'].toString()),
              const SizedBox(height: 16),
              if (entry['actioned'] == 'false')
                Row(
                  children: [
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        controller.fetchupdatedUrls(
                            value: 'accept',
                            ids: controller.selectedOrder!.id.toString());
                      },
                      child: const Text(
                        'Accept',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () => {
                        controller.fetchupdatedUrls(
                            value: 'reject',
                            ids: controller.selectedOrder!.id.toString())
                      },
                      child: const Text(
                        'Reject',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Accepted',
                  style: TextStyle(color: Colors.green),
                )
            ],
          ),
        ),
        Text(
          '£${entry['price']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 89, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildShipmentDetails() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_shipping, size: 24),
                SizedBox(width: 8),
                Text(
                  'Other Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Divider(height: 24, color: Colors.grey),
            Text(
                '${controller.selectedOrder?.firstName ?? 'First Name'} ${controller.selectedOrder?.lastName ?? 'Last Name'}'),
            SizedBox(height: 4),
            Text(controller.selectedOrder?.phone ?? 'No Phone Number Added'),
            SizedBox(height: 4),
            Text(controller.selectedOrder?.street ?? 'No Address Added'),
            SizedBox(height: 12),
            Text(
                'Delivery Method: ${controller.selectedOrder?.deliveryOption ?? 'No Delivery Option Selected'}'),
            SizedBox(height: 4),
            Text(
                'Total Amount to be Paid: £${controller.selectedOrder?.models?.fold<num>(0, (sum, element) => sum + (element.manage_price ?? 0))}.00'),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildModelDetails() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.phone, size: 24),
                SizedBox(width: 8),
                Text(
                  'Model Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Divider(height: 24, color: Colors.grey),
            ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade300,
                    ),
                itemCount: controller.selectedOrder?.models?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  MobilePhonesModel model =
                      controller.selectedOrder!.models?[index] ?? [][index];
                  return Row(
                    children: [
                      Image.network(model.image ?? '', height: 100, width: 100),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  model.name.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '£${model.manage_price ?? 0}.00',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model.questions?.length ?? 0,
                                itemBuilder: (context, indexx) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          model.questions?[indexx]
                                                  ['question'] ??
                                              'No Question'.toString(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        model.questions?[indexx]
                                                ['selected_answer'] ??
                                            'No Answer Selected'.toString(),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
