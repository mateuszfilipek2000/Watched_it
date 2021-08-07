import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/home/controllers/home_controller.dart';

class NavBarController extends GetxController {
  NavBarController({required this.amountOfNavBarTabs});

  RxInt activePageIndex = RxInt(0);
  final int amountOfNavBarTabs;

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.search_rounded,
    Icons.assistant_navigation,
    Icons.account_box_rounded,
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //
  void changeActivePage(int newPageIndex) {
    if (newPageIndex != activePageIndex.value) {
      this.activePageIndex.value = newPageIndex;
      Get.find<HomeController>().pageController.value.animateToPage(
            this.activePageIndex.value,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
      update();
      print(newPageIndex);
    }
  }
}
