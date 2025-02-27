// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/modules/checkout/controllers/checkout_controller.dart';

class DeliveryOptionWidget extends StatefulWidget {
  const DeliveryOptionWidget({super.key});

  @override
  _DeliveryOptionWidgetState createState() => _DeliveryOptionWidgetState();
}

class _DeliveryOptionWidgetState extends State<DeliveryOptionWidget> {
  String _selectedOption = 'Royal Mail Digital Label';

  void _onOptionSelected(String option) {
    Get.find<CheckoutController>().setDeliveryOptions(option);
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildDeliveryOption(
            title: 'Royal Mail Digital Label',
            subtitle:
                "We'll email you a digital label. Package the device you're selling, take to the Post Office and show them the digital label on your phone.",
            badge: 'Fastest',
            icon: Icons.mail_outline,
          ),
          _buildDeliveryOption(
            title: 'Physical label',
            subtitle:
                "We'll post you a pre-paid envelope and label. Package the device you're selling, attach the label then take to the Post Office.",
            badge: '',
            icon: Icons.local_shipping,
          ),
          _buildDeliveryOption(
            title: 'Collection from Home or Work',
            subtitle:
                "Select a date, then on your collection day simply hand over your phone to DPD, who will place it in a protective pack and bring it safely to us.",
            badge: 'Premium',
            icon: Icons.home,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Center(
      child: Column(
        children: [
          Text(
            'Your Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'We need this in case we need to return your device to you',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption({
    required String title,
    required String subtitle,
    required String badge,
    required IconData icon,
  }) {
    final isSelected = _selectedOption == title;

    return GestureDetector(
      onTap: () => _onOptionSelected(title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.pink : Colors.grey,
                size: 40,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOptionTitle(title, badge, isSelected),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.pink,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTitle(String title, String badge, bool isSelected) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.pink : Colors.black,
            ),
          ),
        ),
        if (badge.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badge == 'Fastest' ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badge,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
