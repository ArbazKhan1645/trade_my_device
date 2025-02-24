import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/routes/app_pages.dart';

class MyAppMobile extends StatelessWidget {
  const MyAppMobile({super.key});

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
              "Selling your mobile phone or tech couldn't be easier with WeBuyAnyPhone. Just follow our three simple steps below to see how much you could get for your old device, even if it's broken or damaged.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/phones.png',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Get a Quote",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Start by selecting your device from our easy-to-use search tool. Whether it’s a phone, tablet, laptop, or any other electronic gadget, we’ve got you covered. Once you’ve selected your device, provide a few details about its condition, and we’ll give you an instant quote.",
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
              "Ship Your Device ",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Once you are happy with the quote, we’ll provide you with a pre-paid shipping label. Just pack up your device securely and drop it off at your nearest shipping location. We’ll cover the shipping costs, so there’s no need to worry about additional fees.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/mobile2.png',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Device Evaluation",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "After receiving your device, our team will carefully inspect it to ensure it matches the condition you reported. If everything checks out, we’ll process your payment.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              "Get Paid Fast",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "After the evaluation, you’ll receive your payment via your chosen method—whether it’s through PayPal, bank transfer, or store credit. It’s that simple! We aim to make sure you get paid quickly and fairly.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/mobile.png',
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Why sell with Trademydevice.com?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "WeBuyAnyPhone.com buys pre-owned smartphones, tablets and other tech, whatever condition it's in. Great quality devices are refurbished and resold onto other customer to provide a second lease of life. Those that can't be made as good as new are responsibly recycled.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                const Text(
                  "It’s as easy as that! You get cash or credit for your old devices while helping the environment. Ready to trade in your device?!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.HOME);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    "Get Started now",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      );
    });
  }
}
