import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuywesell/app/routes/app_pages.dart';

import '../../../core/utils/thems/theme.dart';

class MobileFooterPageView extends StatelessWidget {
  const MobileFooterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/footer.png'), fit: BoxFit.fill)),
      child: LayoutBuilder(builder: (context, constraints) {
        double getPadding(double width) {
          if (width >= 1200) {
            return 150.0; // Large screen
          } else if (width >= 800) {
            return 50.0; // Medium screen
          } else {
            return 20.0; // Small screen
          }
        }

        double padding = getPadding(constraints.maxWidth);
        return Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Column(
            children: [
              SizedBox(height: 70),
              LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth <= 700) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InformationWidget(
                              heading: 'Comapny',
                              options: [
                                'Home',
                                'About Us',
                                'How it Work',
                              ],
                            ),
                          ),
                          Expanded(
                            child: InformationWidget(
                              heading: 'Account',
                              options: [
                                'Login',
                                'My Account',
                                'View Basket',
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InformationWidget(
                              heading: 'Legal',
                              options: [
                                'Terms and Conditions',
                                'Privacy Policy',
                                'GDPR Policy',
                              ],
                            ),
                          ),
                          Expanded(child: NewsLetterWidget()),
                        ],
                      )
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InformationWidget(
                        heading: 'Comapny',
                        options: [
                          'Home',
                          'About Us',
                          'How it Work',
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InformationWidget(
                        heading: 'Account',
                        options: [
                          'Login',
                          'My Account',
                          'View Basket',
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InformationWidget(
                        heading: 'Legal',
                        options: [
                          'Terms and Conditions',
                          'Privacy Policy',
                          'GDPR Policy',
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(child: NewsLetterWidget()),
                  ],
                );
              }),
              SizedBox(height: 20),
              Divider(
                color: Color.fromARGB(255, 129, 140, 152),
              ),
              SizedBox(height: 20),
              Text(
                'Copyright © 2025. TICOR ASSOCIATES LIMITED t/a TradeMyDevice is registered in the Northern Ireland under registration number NI643607.',
                textAlign: TextAlign.center,
                style: GoogleFonts.cabin(
                  color: Color.fromARGB(255, 129, 140, 152),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}

class InformationWidget extends StatefulWidget {
  const InformationWidget({
    super.key,
    required this.heading,
    required this.options,
  });

  final String heading;
  final List<String> options;

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  Map<String, bool> isHovered = {};

  @override
  void initState() {
    super.initState();
    for (var option in widget.options) {
      isHovered[option] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: GoogleFonts.cabin(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.options.map((option) {
            return MouseRegion(
              onEnter: (_) => setState(() => isHovered[option] = true),
              onExit: (_) => setState(() => isHovered[option] = false),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton(
                  onPressed: () => navigateToPage(option),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: GoogleFonts.cabin(
                      color: isHovered[option]!
                          ? Colors.white
                          : const Color.fromARGB(255, 129, 140, 152),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                    child: Text(option),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class NewsLetterWidget extends StatelessWidget {
  const NewsLetterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NewsLetter',
          style: defaultTextStyle.copyWith(fontSize: 14, color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.white,
              )),
              child: const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none),
              ),
            )),
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), color: Colors.orange),
              child: const Center(
                child: Text(
                  'Send',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            'Sector F17 Street 46 , house 1137 , MPCHS , Islamabad , Pakistan ',
            style: defaultTextStyle.copyWith(
                fontSize: 14,
                color: Color.fromARGB(255, 129, 140, 152),
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

void navigateToPage(String option) {
  switch (option) {
    case 'Home':
      Get.offAllNamed(Routes.HOME);
      break;
    case 'About Us':
      Get.offAllNamed(Routes.ABOUT_US);
      break;
    case 'Contact Us':
      Get.offAllNamed(Routes.HOME);
      break;
    case 'How it Work':
      Get.offAllNamed(Routes.HOW_ITS_WORK);
      break;
    case 'Login':
      Get.toNamed(Routes.AUTHENTICATION);
      break;
    case 'My Account':
      Get.offAllNamed(Routes.PROFILE_SCREEN);
      break;
    case 'View Basket':
      Get.offAllNamed(Routes.Payment);
      break;
    case 'Terms and Conditions':
      Get.offAllNamed(Routes.SUPPORT_CENTER, arguments: {
        'option': 'Conditions',
      });
      break;
    case 'Privacy Policy':
      Get.offAllNamed(Routes.SUPPORT_CENTER, arguments: {
        'option': 'Other',
      });
      break;
    case 'GDPR Policy':
      Get.offAllNamed(Routes.SUPPORT_CENTER, arguments: {
        'option': 'GDR Policy',
      });
      break;
    default:
      Get.offAllNamed(Routes.HOME);
  }
}
