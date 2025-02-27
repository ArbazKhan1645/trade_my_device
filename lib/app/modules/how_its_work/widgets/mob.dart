// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/routes/app_pages.dart';

class HowItsWorkBody extends StatelessWidget {
  const HowItsWorkBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = constraints.maxWidth >= 1200
            ? 250.0
            : constraints.maxWidth >= 800
                ? 150.0
                : 20.0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              _buildTitle("We make selling your old device effortless"),
              _buildText(
                "Selling your mobile or tech couldn't be simpler with TradeMyDevice. Just follow our three straightforward steps to discover how much you could get for your old device, even if it’s damaged.",
              ),
              _buildImage('assets/images/phones.png'),
              _buildStep(
                "Get a Quote",
                "Start by selecting your device using our user-friendly search tool. Whether it’s a phone, tablet, laptop, or another gadget, we’ve got you covered. Provide details about its condition, and we’ll offer an instant quote.",
                'assets/images/ph1.png',
              ),
              _buildStep(
                "Ship Your Device",
                "Happy with the quote? We'll provide a pre-paid shipping label. Securely pack your device and drop it off at the nearest location. No extra shipping costs!",
                'assets/images/mobile2.png',
              ),
              _buildStep(
                "Device Evaluation",
                "Once we receive your device, our team will carefully inspect it. If everything matches your description, we’ll process your payment swiftly.",
                null,
              ),
              _buildStep(
                "Get Paid Quickly",
                "After evaluation, you’ll receive your payment via your chosen method—PayPal, bank transfer, or store credit. It’s that simple! We ensure a fast and fair process.",
                'assets/images/mobile.png',
              ),
              _buildTitle("Why sell with TradeMyDevice?"),
              _buildText(
                "TradeMyDevice.co.uk buys pre-owned smartphones, tablets, and other tech, regardless of their condition. High-quality devices are refurbished and resold, while those beyond repair are responsibly recycled.",
              ),
              const SizedBox(height: 40),
              _buildText(
                "It’s that easy! Get cash or credit for your old devices while helping the environment. Ready to trade in your device?",
              ),
              _buildGetStartedButton(),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildImage(String assetPath) {
    return Center(
      child: Image.asset(assetPath),
    );
  }

  Widget _buildStep(String title, String description, String? imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildTitle(title),
        _buildText(description),
        if (imagePath != null) _buildImage(imagePath),
      ],
    );
  }

  Widget _buildGetStartedButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        onPressed: () {
          Get.offAllNamed(Routes.HOME);
        },
        child: const Text(
          "Get Started Now",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
