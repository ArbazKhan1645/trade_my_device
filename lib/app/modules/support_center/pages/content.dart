import 'package:flutter/material.dart';

class SupportSection extends StatefulWidget {
  const SupportSection({super.key});

  @override
  State<SupportSection> createState() => _SupportSectionState();
}

class _SupportSectionState extends State<SupportSection> {
  String selectedCategory = 'Payment';
  String selectedSubOption = '';

  // Demo data structure
  final Map<String, List<Map<String, String>>> categories = {
    'Payment': [
      {
        'title': 'Payment Methods',
        'content':
            'We accept various payment methods including credit cards, PayPal, and bank transfers...'
      },
      {
        'title': 'Refund Policy',
        'content':
            'Our refund policy ensures customer satisfaction. Refunds are processed within 5-7 business days...'
      },
    ],
    'Postage': [
      {
        'title': 'Shipping Information',
        'content':
            'We offer worldwide shipping with tracking available for all orders...'
      },
      {
        'title': 'Delivery Times',
        'content':
            'Standard delivery takes 3-5 business days within the country...'
      },
    ],
    'Conditions': [
      {
        'title': 'Terms of Service',
        'content':
            'Please read our terms of service carefully before using our platform...'
      },
      {
        'title': 'Usage Policy',
        'content': 'Our usage policy outlines acceptable use of our services...'
      },
    ],
    'Sales': [
      {
        'title': 'Current Offers',
        'content': 'Check out our latest sales and promotional offers...'
      },
    ],
    'Device': [
      {
        'title': 'Supported Devices',
        'content': 'We support all major smartphone brands and models...'
      },
    ],
    'Other': [
      {
        'title': 'Privacy Policy',
        'content':
            'This privacy policy sets out how we use and protect any information you give us...'
      },
      {
        'title': 'Cookie Policy',
        'content':
            'Our cookie policy explains how we use cookies and similar technologies...'
      },
      {
        'title': 'Complaints',
        'content':
            'If you wish to raise a complaint, please follow these instructions...'
      },
    ],
  };

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left sidebar
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  right: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for answers',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.keys.length,
                      itemBuilder: (context, index) {
                        final category = categories.keys.elementAt(index);
                        return ListTile(
                          selected: selectedCategory == category,
                          selectedTileColor: Colors.pink[50],
                          selectedColor: Colors.pink,
                          title: Text(category),
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                              selectedSubOption =
                                  categories[category]![0]['title']!;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            // Right content area
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Breadcrumb
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Support Home > $selectedCategory > $selectedSubOption',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    // Content
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories[selectedCategory]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = categories[selectedCategory]![index];
                        return Card(
                          margin: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(item['content']!),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
