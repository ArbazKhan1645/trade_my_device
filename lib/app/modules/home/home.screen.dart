// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/home.controller.dart';
import 'view/homepage_view.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override

  Widget build(BuildContext context) {
    return const HomePageViewScreen(storeId: '');
  }
}
