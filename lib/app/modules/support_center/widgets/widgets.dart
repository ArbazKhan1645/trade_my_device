// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FAQController extends GetxController {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  RxList<FAQItem> faqItems = <FAQItem>[].obs;
  RxList<FAQItem> filteredItems = <FAQItem>[].obs;
  RxBool isLoading = true.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadFAQs();
  }

  Future<void> loadFAQs() async {
    isLoading.value = true;
    try {
      final response = await _supabaseClient.from('faqs').select().order('id');

      final List<dynamic> data = response;
      faqItems.value = data.map((item) => FAQItem.fromJson(item)).toList();
      filteredItems.value = List.from(faqItems);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load FAQs: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void filterFAQs(String query) {
    if (query.isEmpty) {
      filteredItems.value = List.from(faqItems);
    } else {
      filteredItems.value = faqItems
          .where((item) =>
              item.question.toLowerCase().contains(query.toLowerCase()) ||
              item.answer.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> addFAQ(String question, String answer) async {
    try {
      final response = await _supabaseClient.from('faqs').insert({
        'question': question,
        'answer': answer,
      }).select();

      if (response.isNotEmpty) {
        final newItem = FAQItem.fromJson(response[0]);
        faqItems.add(newItem);
        filteredItems.value = List.from(faqItems);
        Get.back(); // Close the dialog
        Get.snackbar('Success', 'FAQ added successfully',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add FAQ: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class FAQItem {
  final int id;
  final String question;
  final String answer;
  final RxBool isExpanded = false.obs;

  FAQItem({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FAQItem.fromJson(Map<String, dynamic> json) {
    return FAQItem(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}

class FAQScreen extends StatelessWidget {
  final FAQController controller = Get.put(FAQController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double getPadding(double width) {
        if (width >= 1200) {
          return 200.0; // Large screen
        } else if (width >= 800) {
          return 100.0; // Medium screen
        } else {
          return 20.0; // Small screen
        }
      }

      double padding = getPadding(constraints.maxWidth);
      return Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
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
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            'Find Answer',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Frequently asked questions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.filteredItems.isEmpty) {
                return Center(
                  child: Text('No FAQs found'),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.filteredItems.length,
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Divider(height: 2, color: Colors.grey.shade300),
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.filteredItems[index];
                    return Obx(() => ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          title: Text(
                            item.question,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(
                            item.isExpanded.value
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_right,
                          ),
                          dense: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16), // Set the radius of the corners
                          ),
                          onExpansionChanged: (expanded) {
                            item.isExpanded.value = expanded;
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(item.answer,
                                    style: TextStyle(color: Colors.black87)),
                              ),
                            ),
                          ],
                        ));
                  },
                );
              }
            }),
          ],
        ),
      );
    });
  }

  void _showAddFAQDialog(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    final TextEditingController answerController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text('Add New FAQ'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  hintText: 'Enter the question',
                ),
                maxLines: 2,
              ),
              SizedBox(height: 16),
              TextField(
                controller: answerController,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  hintText: 'Enter the answer',
                ),
                maxLines: 4,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (questionController.text.isNotEmpty &&
                  answerController.text.isNotEmpty) {
                controller.addFAQ(
                  questionController.text.trim(),
                  answerController.text.trim(),
                );
              } else {
                Get.snackbar(
                  'Error',
                  'Question and answer cannot be empty',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
