import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageViewController extends GetxController {
  final Rx<PageController> pageController = Rx<PageController>(
    PageController(
      initialPage: 0,
    ),
  );

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
