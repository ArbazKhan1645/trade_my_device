import 'package:flutter/material.dart';

class SellSmartDevicesScreen extends StatelessWidget {
  const SellSmartDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sell your smart devices',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Text(
                    'View more',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.pink,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: const DeviceCard(
                  title: 'Sell my iPhone',
                  imageUrl:
                      'assets/images/mobile.png', // Replace with a valid asset path
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: const DeviceCard(
                  title: 'Sell my Samsung',
                  imageUrl:
                      'assets/images/mobile.png', // Replace with a valid asset path
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: const DeviceCard(
                  title: 'Sell my iPad',
                  imageUrl:
                      'assets/images/mobile.png', // Replace with a valid asset path
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const DeviceCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: 180,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
