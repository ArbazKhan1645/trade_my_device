import 'package:flutter/material.dart';

class Restaurant {
  final String name;
  final String logoPath;
  final double rating;
  final String deliveryTime;
  final String? offer;
  final String? deliveryFee;
  final String? specialTag;

  Restaurant({
    required this.name,
    required this.logoPath,
    required this.rating,
    required this.deliveryTime,
    this.offer,
    this.deliveryFee,
    this.specialTag,
  });
}

class PopularBrandsWidget extends StatelessWidget {
  final List<Restaurant> restaurants = [
    Restaurant(
      name: 'Iphone 13 pro max',
      logoPath: 'assets/images/mobile.png',
      rating: 4.6,
      deliveryTime: '25 - 40 min',
      offer: 'Spend £20, get 20% off',
    ),
    Restaurant(
      name: 'Iphone 13 pro max',
      logoPath: 'assets/images/mobile.png',
      rating: 4.5,
      deliveryTime: '25 - 40 min',
      specialTag: 'Deliveroo\'s Choice',
    ),
    Restaurant(
      name: 'Iphone 13 pro max',
      logoPath: 'assets/images/mobile.png',
      rating: 4.7,
      deliveryTime: '30 - 50 min',
      offer: 'Spend £25, get 10% off',
    ),
    Restaurant(
      name: 'Iphone 13 pro max',
      logoPath: 'assets/images/mobile.png',
      rating: 4.9,
      deliveryTime: '30 - 45 min',
      deliveryFee: '£3.79 delivery',
    ),
    Restaurant(
      name: 'Iphone 13 pro max',
      logoPath: 'assets/images/mobile.png',
      rating: 4.6,
      deliveryTime: '30 - 50 min',
      deliveryFee: '£4.29 delivery',
    ),
    Restaurant(
      name: 'Iphone 13 pro max',
      logoPath: 'assets/images/mobile.png',
      rating: 4.9,
      deliveryTime: '25 - 40 min',
      offer: 'Spend £15, get 20% off, Tasty...',
    ),
    Restaurant(
      name: 'Iphone 13 pro max',
      logoPath: 'assets/images/mobile.png',
      rating: 4.7,
      deliveryTime: '20 - 40 min',
      deliveryFee: '£1.29 delivery',
    ),
  ];

  PopularBrandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Most Popular',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      'View All',
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
        ),
        _buildRestaurantGrid(restaurants)
      ],
    );
  }

  Widget _buildRestaurantGrid(List<Restaurant> restaurants) {
    return Wrap(
      spacing: 10, // Horizontal spacing between items
      runSpacing: 10, // Vertical spacing between rows
      children: restaurants.map((restaurant) {
        return SizedBox(
          width: 365, // Width of each restaurant card
          child: _buildRestaurantCard(restaurant),
        );
      }).toList(),
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Container(
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(restaurant.logoPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(restaurant.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('${restaurant.rating} · ${restaurant.deliveryTime}'),
                    ],
                  ),
                  if (restaurant.offer != null)
                    Text(restaurant.offer!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12)),
                  if (restaurant.deliveryFee != null)
                    Text(restaurant.deliveryFee!,
                        style: const TextStyle(color: Colors.grey)),
                  if (restaurant.specialTag != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        restaurant.specialTag!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
