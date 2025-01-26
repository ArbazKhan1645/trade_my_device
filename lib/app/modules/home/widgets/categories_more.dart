import 'dart:ui';

import 'package:flutter/material.dart';

class CategoriesDialog extends StatelessWidget {
  final List<Category> categories = [
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
    Category('Groceries', 46),
    Category('Deals', 118),
    Category('Breakfast', 64),
  ];

  CategoriesDialog({super.key});

  final ScrollController scrollController = ScrollController();

  void _scrollUp() {
    scrollController.animateTo(
      scrollController.offset - 100, // Scroll up by 100 pixels
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.offset + 100, // Scroll down by 100 pixels
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search in categories',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: RawScrollbar(
                      controller: scrollController,
                      thumbColor: Colors.grey[400]!,
                      radius: const Radius.circular(20),
                      thickness: 8,
                      thumbVisibility: true,
                      trackVisibility: true,
                      trackColor: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryItem(category: categories[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                  // Scroll Up Button at the top of the scrollbar
                  Positioned(
                    top: -10,
                    right: -10, // Position relative to the scrollbar's position
                    child: InkWell(
                      onTap: _scrollUp,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.arrow_drop_up,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Scroll Down Button at the bottom of the scrollbar
                  Positioned(
                    bottom: -10,
                    right: -10, // Position relative to the scrollbar's position
                    child: InkWell(
                      onTap: _scrollDown,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.arrow_drop_up,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}

class Category {
  final String name;
  final int count;

  Category(this.name, this.count);
}

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        '${category.name} (${category.count})',
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

void showCategoriesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CategoriesDialog();
    },
  );
}
