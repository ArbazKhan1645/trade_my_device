import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        NavItem(title: 'Sell my iPad'),
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.cabin(
                    color: isHovered ? Colors.pink : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                if (widget.dropdownContent != null)
                  Icon(
                    isHovered ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: isHovered ? Colors.pink : Colors.black,
                  )
              ],
            ),
          ),
          if (isHovered && widget.dropdownContent != null)
            Positioned(
              top: 70,
              left: 0,
              child: widget.dropdownContent!,
            ),
        ],
      ),
    );
  }
}

class PhoneDropdownContent extends StatelessWidget {
  const PhoneDropdownContent({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhoneSection(
            title: 'Apple iPhone',
            phones: [
              'iPhone 15 Pro Max',
              'iPhone 15 Pro',
              'iPhone 15',
              'iPhone 14 Pro Max',
              'iPhone 14 Pro',
              'iPhone 14',
              'iPhone 13 Pro Max',
              'iPhone 13 Pro',
            ],
          ),
          SizedBox(width: 40),
          PhoneSection(
            title: 'Samsung Phone',
            phones: [
              'Galaxy S22 Ultra 5G',
              'Galaxy S22 Plus 5G',
              'Galaxy S22 5G',
              'Galaxy S21 Ultra 5G',
              'Galaxy S21 Plus 5G',
              'Galaxy S21 5G',
              'Galaxy S20 Ultra 5G',
              'Galaxy S20 Plus 5G',
              'Galaxy S20 5G',
            ],
          ),
          SizedBox(width: 40),
          PhoneSection(
            title: 'Sell my Phone',
            phones: [
              'Sell my Apple iPhone',
              'Sell my Samsung Phone',
              'Sell my Google Phone',
              'Sell my Huawei Phone',
              'Sell my Broken Phone',
            ],
          ),
        ],
      ),
    );
  }
}

class PhoneSection extends StatelessWidget {
  final String title;
  final List<String> phones;

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
          Image.asset(
            'assets/images/mobile.png',
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
                      phone,
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
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const Icon(Icons.chevron_right,
                          size: 16, color: Colors.blue),
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
