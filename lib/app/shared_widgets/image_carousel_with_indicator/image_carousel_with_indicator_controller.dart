import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarouselWithIndicatorController extends GetxController {
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }
}
