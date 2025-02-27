// main.dart
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/support_center_controller.dart';

class SupportCenterBodyWidget extends StatelessWidget {
  final SupportCenterController controller = Get.put(SupportCenterController());

  SupportCenterBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double padding = _calculatePadding(constraints.maxWidth);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 50),
              _buildFAQHeader(),
              const SizedBox(height: 30),
              _buildFAQList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              decoration: const InputDecoration(
                hintText: 'Search for answers',
                border: InputBorder.none,
              ),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              controller.filterFAQs(controller.searchController.text);
            },
            child: Container(
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text(
                  'Find Answer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQHeader() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Frequently asked questions',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFAQList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: LinearProgressIndicator());
      }

      if (controller.filteredItems.isEmpty) {
        return const Center(child: Text('No FAQs found'));
      }

      return ListView.separated(
        shrinkWrap: true,
        itemCount: controller.filteredItems.length,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 2, color: Colors.grey.shade300),
          );
        },
        itemBuilder: (context, index) {
          final item = controller.filteredItems[index];
          return _buildFAQItem(item);
        },
      );
    });
  }

  Widget _buildFAQItem(FAQItem item) {
    return Obx(() {
      return ExpansionTile(
        backgroundColor: Colors.grey.shade200,
        title: Text(
          item.question,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          item.isExpanded.value
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_right,
        ),
        dense: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onExpansionChanged: (expanded) {
          item.isExpanded.value = expanded;
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.answer,
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ],
      );
    });
  }

  double _calculatePadding(double width) {
    if (width >= 1200) return 200.0;
    if (width >= 800) return 100.0;
    return 20.0;
  }
}
