import 'package:flutter/material.dart';

class MyAppMobile extends StatelessWidget {
  const MyAppMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get a great device at a fraction of the price",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Don't buy a new phone!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Buy a certified refurbished one instead!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.pink),
                          SizedBox(width: 10),
                          Text("12-month warranty"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.pink),
                          SizedBox(width: 10),
                          Text("Free delivery"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.pink),
                          SizedBox(width: 10),
                          Text("Unlocked & SIM free"),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // Add your button action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        child: const Text(
                          "Shop refurbished",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/phones.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
