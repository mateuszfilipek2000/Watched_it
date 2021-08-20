import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarouselController extends GetxController {
  ImageCarouselController(viewportFraction, this.minimumChildScale)
      : pageController =
            PageController(initialPage: 0, viewportFraction: viewportFraction);

  RxInt activeChildIndex = 0.obs;
  RxDouble pageValue = 0.0.obs;

  final PageController pageController;
  final double minimumChildScale;

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
    print("disposing carousel controller");
    pageController.dispose();
    super.onClose();
  }
}
