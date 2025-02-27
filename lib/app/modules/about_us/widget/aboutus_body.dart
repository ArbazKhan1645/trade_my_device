// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

class AboutusBodyScreen extends StatelessWidget {
  const AboutusBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double padding = _calculatePadding(constraints.maxWidth);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildImageSection('assets/images/person.png', height: 400),
              const SizedBox(height: 20),
              _buildSectionTitle("Who We Are"),
              const SizedBox(height: 10),
              _buildSectionText(
                "We’re a team of tech enthusiasts, environmental advocates, and customer-focused professionals who are passionate about helping you get the most value from your unused devices. Whether you have an old smartphone, laptop, tablet, or other electronics lying around, we make it effortless for you to trade them in and receive cash, store credit, or gift cards.",
              ),
              const SizedBox(height: 20),
              _buildImageSection('assets/images/ph1.png'),
              const SizedBox(height: 20),
              _buildSectionTitle("Why Choose Us?"),
              const SizedBox(height: 10),
              _buildSectionText(
                "Instant Quotes: We offer quick, fair, and accurate quotes for your devices, ensuring you get the best value.\n"
                "Hassle-Free Process: From the moment you submit your device to when you receive your payment, our process is designed to be as simple and seamless as possible.\n"
                "Fast Payments: Once your device is evaluated, we send your payment quickly through a variety of convenient methods—so you don’t have to wait.\n"
                "Sustainability Focus: We believe in reducing e-waste and promoting the reuse of electronics. If your device isn't in a resellable condition, we make sure it’s properly recycled to minimise environmental impact.\n"
                "Our Commitment to You: We understand that parting with your devices can feel like a big decision. That’s why we offer transparency and customer support every step of the way. Our team is here to answer any questions you have and ensure you feel confident throughout the process.",
              ),
              const SizedBox(height: 20),
              _buildImageSection('assets/images/phones.png'),
              const SizedBox(height: 50),
              _buildSectionText(
                "With Trade My Device, you’re not just getting rid of an old gadget; you’re making a smart, responsible choice for both your wallet and the planet.",
              ),
              const SizedBox(height: 10),
              _buildSectionText(
                "Thank you for choosing us—we’re excited to help you trade your device!",
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildImageSection(String imagePath, {double? height}) {
    return Center(
      child: Image.asset(
        imagePath,
        height: height,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }

  double _calculatePadding(double width) {
    if (width >= 1200) return 250.0;
    if (width >= 800) return 150.0;
    return 20.0;
  }
}
