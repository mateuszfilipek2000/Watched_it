import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarouselController extends GetxController {
  RxInt leftLimitIndex = 0.obs;
  RxInt activeChildIndex = 0.obs;
  RxInt rightLimitIndex = 4.obs;
  RxDouble pageValue = 0.0.obs;

  PageController pageController = PageController(viewportFraction: 0.7);

  @override
  void onInit() {
    pageController
      ..addListener(() {
        if (pageController.page != null) {
          pageValue.value = pageController.page as double;
          //print(pageController.page);
        }
      });
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
