// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:webuywesell/app/modules/authentication/authentication_view.dart';

import '../../../core/utils/thems/theme.dart';
import '../controllers/drawer.dart';
import '../controllers/nav.dart';

class HomePageHeaderWidget extends StatelessWidget {
  const HomePageHeaderWidget({super.key, this.constraints});
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/b.svg',
              fit: BoxFit.cover,
              color: Color(0xffFFC000),
            ),
          ),
          buildMiniHeader(context),
          buildSubHeader(context, constraints: constraints),
        ],
      ),
    );
  }

  buildMiniHeader(BuildContext context) {
    double getPadding(double width) {
      if (width >= 1200) {
        return 100.0; // Large screen
      } else if (width >= 800) {
        return 50.0; // Medium screen
      } else {
        return 20.0; // Small screen
      }
    }

    double padding = getPadding(constraints!.maxWidth);

    return Positioned(
        top: 15,
        left: 0,
        right: 0,
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              // Foreground content (the Row with widgets)
              Row(
                children: [
                  SizedBox(width: 15),
                  buildheadertext(),
                  SizedBox(width: 15),
                  Expanded(
                    child: Builder(builder: (context) {
                      Widget widget = Row(
                        children: [
                          buildwidget(
                              Icons.email_outlined, 'info@trademydevice.co.uk'),
                          SizedBox(width: 15),
                          buildVerticalDivider(),
                          SizedBox(width: 15),
                          buildwidget(Icons.location_on_outlined,
                              'London England, G53'),
                          const Spacer(),
                          buildCountryWidget(),
                          SizedBox(width: 15),
                          buildVerticalDivider(),
                          SizedBox(width: 15),
                          buildThemeWidget(),
                          SizedBox(width: 15),
                        ],
                      );
                      if (constraints != null) {
                        if (constraints!.maxWidth >= 800) {
                          return widget;
                        } else {
                          return RowWidget();
                        }
                      }
                      return widget;
                    }),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  buildThemeWidget() {
    return Row(
      children: [
        Text('Dark', style: defaultTextStyle),
        SizedBox(width: 15),
        const Icon(Icons.dark_mode_outlined, size: 20)
      ],
    );
  }

  buildheadertext() {
    return Text('Trade My Device', style: defaultTextStyle);
  }

  buildCountryWidget() {
    return Row(
      children: [
        SvgPicture.asset('assets/images/usd.svg', height: 20, width: 20),
        SizedBox(width: 15),
        Text('English', style: defaultTextStyle),
        const Icon(Icons.arrow_drop_down),
      ],
    );
  }

  buildVerticalDivider() {
    return Container(
      height: 20,
      width: 1,
      color: Colors.black,
    );
  }

  buildwidget(IconData icon, String texts) {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 20),
        SizedBox(width: 1.5),
        Text(texts, style: defaultTextStyle),
      ],
    );
  }
}

class HomeTitlesWidget extends StatefulWidget {
  const HomeTitlesWidget(
      {super.key, required this.selectedPageName, required this.isSelected});
  final String selectedPageName;
  final bool isSelected;

  @override
  State<HomeTitlesWidget> createState() => _HomeTitlesWidgetState();
}

class _HomeTitlesWidgetState extends State<HomeTitlesWidget> {
  bool isHovering = false;

  void _onHover(bool hovering) {
    if (isHovering != hovering) {
      setState(() {
        isHovering = hovering;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: _onHover,
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: SizedBox(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.selectedPageName,
                  style: TextStyle(
                    color: widget.isSelected
                        ? const Color(0xff6EB356)
                        : const Color(0xff5D6374),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: widget.isSelected
                      ? const Color(0xff6EB356)
                      : const Color(0xff5D6374),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildSubHeader(BuildContext context, {BoxConstraints? constraints}) {
  return Positioned(
      left: 0,
      right: 0,
      bottom: -80,
      child: buildWidgetOFScrollHeader(context, constraints: constraints));
}

buildWidgetOFScrollHeader(BuildContext context, {BoxConstraints? constraints}) {
  return Container(
    width: double.infinity,
    color: Colors.white,
    child: Container(
      width: double.infinity,
      color: Colors.white,
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.1),
      //       offset: const Offset(0, 4),
      //       blurRadius: 0,
      //       spreadRadius: 0,
      //     ),
      //   ],
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      // ),
      height: 80,
      child: Row(
        children: [
          const SizedBox(width: 20), // Updated horizontalSpace with SizedBox
          Image.asset('assets/images/trade.jpeg'),
          const Spacer(),
          Builder(builder: (context) {
            if (constraints != null) {
              if (constraints.maxWidth >= 1200) {
                return const AddressInfoToggle(address: 'GlassGow PK');
              } else {
                return Container();
              }
            }
            return const AddressInfoToggle(address: 'GlassGow PK');
          }),

          const SizedBox(width: 10), // Updated horizontalSpace with SizedBox
          Container(
            height: 80,
            width: 1,
            color: Colors.grey.shade200,
          ),
          const SizedBox(width: 10), // Updated horizontalSpace with SizedBox
          Builder(builder: (context) {
            Widget widget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Phone & Telephone', style: defaultTextStyle),
                Text('+92 310 2426 676', style: defaultTextStyle),
              ],
            );
            if (constraints != null) {
              if (constraints.maxWidth >= 600) {
                return widget;
              } else {
                return Container();
              }
            }
            return widget;
          }),
          const SizedBox(width: 10), // Updated horizontalSpace with SizedBox
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xffFFF2E6),
                child: Center(
                  child: Icon(Icons.shopping_basket_outlined),
                ),
              ),
              Text('Basket', style: defaultTextStyle),
            ],
          ),
          const SizedBox(width: 10), // Updated horizontalSpace with SizedBox

          Builder(builder: (context) {
            Widget widget = GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FullScreenDialog();
                  },
                  barrierLabel: 'Dialog',
                  transitionDuration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final slideAnimation = Tween<Offset>(
                      begin: Offset(1.0, 0.0),
                      end: Offset(0.0, 0.0),
                    ).animate(animation);

                    final reverseSlideAnimation = Tween<Offset>(
                      begin: Offset(0.0, 0.0),
                      end: Offset(1.0, 0.0),
                    ).animate(secondaryAnimation);

                    return SlideTransition(
                      position: animation.status == AnimationStatus.reverse
                          ? reverseSlideAnimation
                          : slideAnimation,
                      child: child,
                    );
                  },
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                );
                // showAnimatedDialog(context);
              },
              child: Container(
                height: 90,
                width: 80,
                decoration: const BoxDecoration(
                  color: Color(0xffFFC000),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xffFFF2E6),
                      child: Center(
                        child: Icon(Icons.menu),
                      ),
                    ),
                    Text('menu', style: defaultTextStyle),
                  ],
                ),
              ),
            );
            if (constraints != null) {
              if (constraints.maxWidth >= 1200) {
                return Container();
              } else {
                return widget;
              }
            }
            return widget;
          }),
        ],
      ),
    ),
  );
}

Widget buildDot() {
  return Container(
    margin: const EdgeInsets.all(2.0),
    width: 5,
    height: 5,
    decoration: const BoxDecoration(
      color: Colors.black,
      shape: BoxShape.circle,
    ),
  );
}

Widget buildNavigationMenu(BuildContext context) {
  if (MediaQuery.of(context).size.width < 1000) {
    return const SizedBox.shrink();
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _menuItems.map((item) {
      bool isSelected = item == 'Home';
      return HomeTitlesWidget(selectedPageName: item, isSelected: isSelected);
    }).toList(),
  );
}

const List<String> _menuItems = ['Home', 'Menu', 'Contact', 'My Account'];

Widget buildActionIcons() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _buildIconWithLabel(
        icon: Icons.favorite_border_outlined,
        label: 'WishList',
      ),
      const SizedBox(width: 10),
      _buildIconWithLabel(
        icon: Icons.shopping_basket_outlined,
        label: 'My Cart',
        additionalText: '£23.98',
        additionalTextColor: const Color(0xff6EB356),
      ),
    ],
  );
}

Widget _buildIconWithLabel(
    {required IconData icon,
    required String label,
    String? additionalText,
    Color? additionalTextColor}) {
  return Row(
    children: [
      IconButton(
        onPressed: () {},
        icon: Icon(icon, color: const Color(0xff5D6374), size: 20),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Color(0xff5D6374),
                  fontWeight: FontWeight.w400,
                  fontSize: 16)),
          if (additionalText != null)
            Text(
              additionalText,
              style: TextStyle(
                  color: additionalTextColor ?? const Color(0xff5D6374),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
        ],
      ),
    ],
  );
}

class AddressInfoToggle extends StatefulWidget {
  final String address;

  const AddressInfoToggle({super.key, required this.address});

  @override
  _AddressInfoToggleState createState() => _AddressInfoToggleState();
}

class _AddressInfoToggleState extends State<AddressInfoToggle> {
  final bool _isDelivery = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: NavigationBarWithDropdown(),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon,
                      color:
                          isSelected ? const Color(0xFF00CCBC) : Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Great",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: List.generate(5, (index) {
            return Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: index == 4 ? Colors.white : Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.star,
                size: 16,
                color: index == 4 ? Colors.grey : Colors.white, // Star color
              ),
            );
          }),
        ),
      ],
    );
  }
}
