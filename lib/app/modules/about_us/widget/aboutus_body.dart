import 'package:flutter/material.dart';

class AboutusBodyScreen extends StatelessWidget {
  const AboutusBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double getPadding(double width) {
        if (width >= 1200) {
          return 250.0; // Large screen
        } else if (width >= 800) {
          return 150.0; // Medium screen
        } else {
          return 20.0; // Small screen
        }
      }

      double padding = getPadding(constraints.maxWidth);
      return Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            const Text(
              "We make selling your old device a breeze",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "At Trade My Device, we believe in making technology more accessible while promoting sustainability. Our mission is simple: to provide an easy, reliable, and eco-friendly way for you to trade in your old devices and get paid quickly.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/images/person.png',
                height: 600,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Who We Are",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We’re a team of tech enthusiasts, environmental advocates, and customer-focused professionals who are passionate about helping you get the most value from your unused devices. Whether you have an old smartphone, laptop, tablet, or other electronics lying around, we make it effortless for you to trade them in and receive cash, store credit, or gift cards.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/ph1.png',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Why Choose Us?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Instant Quotes: We offer quick, fair, and accurate quotes for your devices, ensuring you get the best value."
              "Hassle-Free Process: From the moment you submit your device to when you receive your payment, our process is designed to be as simple and seamless as possible."
              "Fast Payments: Once your device is evaluated, we send your payment quickly through a variety of convenient methods—so you don’t have to wait."
              "Sustainability Focus: We believe in reducing e-waste and promoting the reuse of electronics. If your device isn't in a resellable condition, we make sure it’s properly recycled to minimize environmental impact."
              "Our Commitment to You"
              "We understand that parting with your devices can feel like a big decision. That’s why we offer transparency and customer support every step of the way. Our team is here to answer any questions you have and ensure you feel confident throughout the process.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/phones.png',
              ),
            ),
            const SizedBox(height: 50),
            const SizedBox(height: 10),
            const Text(
              "With Trade My Device, you’re not just getting rid of an old gadget; you’re making a smart, responsible choice for both your wallet and the planet.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Text(
              "Thank you for choosing us—we’re excited to help you trade your device!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      );
    });
  }
}
