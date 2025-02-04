// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:webuywesell/app/modules/home/controllers/home.controller.dart';
import 'package:webuywesell/app/modules/sell_my_phone/models/mobile_phones_model.dart';

class NavigationBarWithDropdown extends StatelessWidget {
  const NavigationBarWithDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        NavItem(
          title: 'Sell my Phone',
          dropdownContent: PhoneDropdownContent(),
        ),
        NavItem(title: 'How it works'),
        NavItem(title: 'Business Recycling'),
        NavItem(title: 'Students'),
        NavItem(title: 'Help Centre'),
      ],
    );
  }
}

class NavItem extends StatefulWidget {
  final String title;
  final Widget? dropdownContent;

  const NavItem({
    required this.title,
    this.dropdownContent,
    super.key,
  });

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool isHovered = false;
  bool isDropdownHovered = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) {
            if (!isDropdownHovered) {
              setState(() => isHovered = false);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.cabin(
                    color: isHovered || isDropdownHovered
                        ? Colors.pink
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                if (widget.dropdownContent != null)
                  Icon(
                    isHovered || isDropdownHovered
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: isHovered || isDropdownHovered
                        ? Colors.pink
                        : Colors.black,
                  )
              ],
            ),
          ),
        ),
        if ((isHovered || isDropdownHovered) && widget.dropdownContent != null)
          Positioned(
            top: 60,
            left: 0,
            child: MouseRegion(
              onEnter: (_) => setState(() => isDropdownHovered = true),
              onExit: (_) => setState(() {
                isDropdownHovered = false;
                isHovered = false;
              }),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: widget.dropdownContent!,
              ),
            ),
          ),
      ],
    );
  }
}

class PhoneDropdownContent extends StatelessWidget {
  const PhoneDropdownContent({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    if (controller.isloading.value) {
      return Container();
    }
    return Container(
      width: 1000,
      height: 500,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.brandsList.take(4).map(
                (e) => PhoneSection(
                    title: e.name.toString(),
                    phones: controller.phoneModels
                        .where((p) => p.brands == e.id)
                        .toList()),
              ),
        ],
      ),
    );
  }
}

class PhoneSection extends StatelessWidget {
  final String title;
  final List<MobilePhonesModel> phones;

  const PhoneSection({
    required this.title,
    required this.phones,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            phones.first.image.toString(),
            height: 60,
            width: 80,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              ...phones.map((phone) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      phone.name.toString(),
                      style: const TextStyle(color: Colors.blue),
                    ),
                  )),
              if (title != 'Sell my Phone')
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Text(
                        'See all ${title}s',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Icon(Icons.chevron_right,
                          size: 16, color: Colors.black),
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
