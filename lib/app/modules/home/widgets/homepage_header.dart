// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/routes/app_pages.dart';
import 'package:trademydevice/main.dart';
import '../../../core/utils/thems/theme.dart';
import '../../../services/auth/auth_service.dart';
import 'menu_drawer.dart';
import 'nav_bar_dropdown.dart';

class HomePageHeaderWidget extends StatelessWidget {
  const HomePageHeaderWidget({super.key, this.constraints});
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
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
          buildSubHeader(context, constraints: constraints),
        ],
      ),
    );
  }
}

Widget buildSubHeader(BuildContext context, {BoxConstraints? constraints}) {
  return Positioned(
      left: 0,
      right: 0,
      bottom: -15,
      child: buildWidgetOFScrollHeader(context, constraints: constraints));
}

buildWidgetOFScrollHeader(BuildContext context, {BoxConstraints? constraints}) {
  double getPadding(double width) {
    if (width >= 1200) {
      return 150.0;
    } else if (width >= 800) {
      return 50.0;
    } else {
      return 0.0;
    }
  }

  double padding =
      getPadding(constraints == null ? 1200 : constraints.maxWidth);
  return Container(
    width: double.infinity,
    color: Colors.white,
    child: Container(
      width: double.infinity,
      color: Colors.white,
      height: 80,
      child: Row(
        children: [
          SizedBox(width: padding),
          GestureDetector(
              onTap: () {
                Get.offAllNamed(Routes.HOME);
              },
              child: Image.asset('assets/images/trade.jpeg')),
          Expanded(
            child: Builder(builder: (context) {
              if (constraints != null) {
                if (constraints.maxWidth >= 1350) {
                  return const NavigationBarWithDropdown();
                } else {
                  return Container();
                }
              }
              return const NavigationBarWithDropdown();
            }),
          ),
          const SizedBox(width: 10),
          Container(
            height: 80,
            width: 1,
            color: Colors.grey.shade200,
          ),
          const SizedBox(width: 10),
          Builder(builder: (context) {
            Widget widget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Contact us', style: defaultTextStyle),
                Text('info@trademydevice.co.uk', style: defaultTextStyle),
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
          const SizedBox(width: 10),
          !AuthService.instance.islogin
              ? GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.AUTHENTICATION);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xffFFF2E6),
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Text('Login', style: defaultTextStyle),
                    ],
                  ),
                )
              : showPopupWidget(),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              Get.offAllNamed(Routes.Payment);
            },
            child: Column(
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
          ),
          const SizedBox(width: 20),
          Builder(builder: (context) {
            Widget widget = GestureDetector(
              onTap: () async {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return MenuDrawerWidget();
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
              if (constraints.maxWidth >= 1350) {
                return Container();
              } else {
                return widget;
              }
            }
            return widget;
          }),
          SizedBox(width: padding)
        ],
      ),
    ),
  );
}
