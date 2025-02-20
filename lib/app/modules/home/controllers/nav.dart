// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuywesell/app/modules/home/controllers/home.controller.dart';
import 'package:webuywesell/app/modules/sell_my_phone/models/mobile_phones_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/app/app_service.dart';

class NavigationBarWithDropdown extends StatefulWidget {
  const NavigationBarWithDropdown({super.key});

  @override
  State<NavigationBarWithDropdown> createState() =>
      _NavigationBarWithDropdownState();
}

class _NavigationBarWithDropdownState extends State<NavigationBarWithDropdown> {
  String? activeDropdown;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _showDropdown(String title) {
    _hideDropdown();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 400,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 75),
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                activeDropdown = title;
              });
            },
            onExit: (_) {
              setState(() {
                activeDropdown = null;
                _hideDropdown();
              });
            },
            child: Material(
              elevation: 8,
              child: _buildDropdownContent(title),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildDropdownContent(String title) {
    switch (title) {
      case 'Sell my Phone':
        return const PhoneDropdownContent();
      default:
        return Container();
    }
  }

  @override
  void dispose() {
    _hideDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onExit: (_) {
          if (_overlayEntry != null && activeDropdown != null) {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (!mounted) return;
              setState(() {
                activeDropdown = null;
                _hideDropdown();
              });
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NavItem(
              title: 'Sell my Phone',
              hasDropdown: true,
              isActive: activeDropdown == 'Sell my Phone',
              onHover: (hover) {
                setState(() {
                  activeDropdown = hover ? 'Sell my Phone' : null;
                  if (hover) {
                    _showDropdown('Sell my Phone');
                  }
                });
              },
            ),
            GestureDetector(
              onTap: () {
                Get.offAllNamed(Routes.HOW_ITS_WORK);
              },
              child: NavItem(
                title: 'How it works',
                isActive: activeDropdown == 'How it works',
                onHover: (hover) {
                  setState(() {
                    activeDropdown = hover ? 'How it works' : null;
                    if (hover) {
                      _hideDropdown();
                    }
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offAllNamed(Routes.SUPPORT_CENTER);
              },
              child: NavItem(
                title: 'Support Centre',
                isActive: activeDropdown == 'Support Centre',
                onHover: (hover) {
                  setState(() {
                    activeDropdown = hover ? 'Support Centre' : null;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final bool hasDropdown;
  final bool isActive;
  final Function(bool) onHover;

  const NavItem({
    required this.title,
    this.hasDropdown = false,
    required this.isActive,
    required this.onHover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.cabin(
                color: isActive ? Colors.pink : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (hasDropdown)
              Icon(
                isActive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: isActive ? Colors.pink : Colors.black,
              ),
          ],
        ),
      ),
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
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 400,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controller.brandsList.take(4).map(
                    (e) => PhoneSection(
                      title: e.name.toString(),
                      phones: controller.phoneModels
                          .where((p) => p.brands == e.id)
                          .toList(),
                    ),
                  ),
            ],
          ),
        ),
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
              ...phones.take(5).map((phone) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextButton(
                    onPressed: () async {
                      await AppService.instance.sharedPreferences
                          .setString('currentPhone', jsonEncode(phone.toJson()))
                          .then((val) {
                        Get.offAllNamed(Routes.DEVICE_INFO);
                      });
                    },
                    child: Text(phone.name.toString(),
                        style: const TextStyle(color: Colors.blue)),
                  ))),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 0, bottom: 40),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.SELL_MY_PHONE, arguments: {
                            'brand': title,
                          });
                        },
                        child: Text(
                          'See all ${title}s',
                          style: const TextStyle(color: Colors.black),
                        )),
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
