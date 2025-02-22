import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/modules/profile_screen/controllers/profile_screen_controller.dart';
import 'package:webuywesell/app/modules/profile_screen/widgets/profile.dart';
import 'package:webuywesell/app/modules/sell_my_phone/models/mobile_phones_model.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final controller = Get.put(ProfileScreenController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrderInfo(),
        const SizedBox(height: 16),
        if (controller.selectedOrder!.timeline!.isNotEmpty) _buildOrderStatus(),
        const SizedBox(height: 16),
        _buildShipmentDetails(),
        const SizedBox(height: 16),
        _buildModelDetails()
      ],
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
                        'Order No: ${controller.selectedOrder!.orderNumber}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Order Status: ${controller.selectedOrder?.status ?? 'N/A'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                      'Placed On: ${formatOrderDate(controller.selectedOrder!.createdAt ?? DateTime.now())}',
                      style: TextStyle(color: Colors.grey)),
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
              children: const [
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

  Widget _buildTimeline() {
    final List<Map<String, String>> timeline = [];
    for (var status in controller.selectedOrder!.timeline!) {
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
    bool isDelivered = false;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isDelivered
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isDelivered ? Colors.blue : Colors.grey,
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
                    entry['status']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDelivered ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(entry['description']!),
              const SizedBox(height: 16),
            ],
          ),
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
                itemCount: controller.selectedOrder!.models!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  MobilePhonesModel model =
                      controller.selectedOrder!.models![index];
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
                                shrinkWrap: true,
                                itemCount: model.questions!.length,
                                itemBuilder: (context, indexx) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          model.questions![indexx]['question']
                                              .toString(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      Text(
                                        model.questions![indexx]
                                                ['selected_answer']
                                            .toString(),
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
