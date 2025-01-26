import 'package:flutter/material.dart';

import '../../../core/utils/thems/theme.dart';

class SellPhoneScreen extends StatelessWidget {
  const SellPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 150, right: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('Sell your phone online',
              style: defaultTextStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.withOpacity(0.05)),
              borderRadius: BorderRadius.circular(8),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.25),
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: const Offset(0, 1),
              //   ),
              // ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoStep(
                      icon: Icons.search,
                      title: 'Search',
                      description: 'Select the device you want to sell',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    InfoStep(
                      icon: Icons.local_shipping,
                      title: 'Send',
                      description: 'Send it to us for free',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    InfoStep(
                      icon: Icons.attach_money,
                      title: 'Get paid',
                      description: 'Fast payments',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Sell by category',
              style: defaultTextStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const CategoryCard(
                    title: 'Sell my Apple iPhone',
                    imageUrl:
                        'assets/images/mobile2.png', // Replace with a valid asset path
                    logo: Icons.apple,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const CategoryCard(
                    title: 'Sell my Samsung Galaxy',
                    imageUrl:
                        'assets/images/mobile2.png', // Replace with a valid asset path
                    logo: Icons.android,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final IconData logo;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.25),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //     offset: const Offset(0, 1),
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(logo, size: 40, color: Colors.black),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                imageUrl,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: defaultTextStyle.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class InfoStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoStep({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.teal),
          const SizedBox(height: 8),
          Text(title, style: defaultTextStyle.copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text(description,
              textAlign: TextAlign.center,
              style: defaultTextStyle.copyWith(
                  color: Color.fromARGB(255, 129, 140, 152))),
        ],
      ),
    );
  }
}
