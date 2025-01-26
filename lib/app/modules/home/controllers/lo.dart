import 'package:flutter/material.dart';

class MyAppguide extends StatelessWidget {
  const MyAppguide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: .0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "It's easy to send your device to us",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Digital Label
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.qr_code, size: 80, color: Colors.purple),
                    SizedBox(height: 10),
                    Text(
                      "Digital Label",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We'll provide a QR label so you can pack your device and take it to the Post Office",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Container(
                width: 1,
                height: 100,
                color: Colors.black.withOpacity(0.2),
              ),
              const SizedBox(width: 30),
              // Physical Label
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_shipping_outlined,
                        size: 80, color: Colors.teal),
                    SizedBox(height: 10),
                    Text(
                      "Physical Label",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We'll provide a pre-paid label so you can pack your device and take it to the Post Office",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Container(
                width: 1,
                height: 100,
                color: Colors.black.withOpacity(0.2),
              ),
              const SizedBox(width: 30),
              // We Come to You
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_taxi, size: 80, color: Colors.green),
                    SizedBox(height: 10),
                    Text(
                      "We come to you",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We come to you and collect your device from your home or work address",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
