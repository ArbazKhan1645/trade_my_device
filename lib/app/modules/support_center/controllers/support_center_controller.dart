// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupportCenterController extends GetxController {
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