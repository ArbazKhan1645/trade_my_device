import 'package:flutter/material.dart';

class BannersWidgetClass extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/promotion.jpeg',
    'assets/images/promotion_next.jpeg',
    'assets/images/promotion.jpeg',
    'assets/images/promotion_next.jpeg',
    'assets/images/promotion.jpeg',
    'assets/images/promotion_next.jpeg',
    'assets/images/promotion.jpeg',
    'assets/images/promotion_next.jpeg',
    'assets/images/promotion.jpeg',
    'assets/images/promotion_next.jpeg',
  ];

  BannersWidgetClass({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
