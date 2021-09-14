// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:watched_it_getx/app/modules/MainPageView/controllers/main_page_view_controller.dart';

// //TODO MOVE TO MAINVIEW FOLDER
// class NavBarController extends GetxController {
//   NavBarController({required this.amountOfNavBarTabs});

//   RxInt activePageIndex = RxInt(0);
//   final int amountOfNavBarTabs;

//   final List<IconData> icons = [
//     Icons.home_rounded,
//     Icons.search_rounded,
//     Icons.explore_rounded,
//     Icons.account_box_rounded,
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   //
//   void changeActivePage(int newPageIndex) {
//     if (newPageIndex != activePageIndex.value) {
//       this.activePageIndex.value = newPageIndex;
//       Get.find<MainPageViewController>().pageController.value.animateToPage(
//             this.activePageIndex.value,
//             duration: Duration(milliseconds: 200),
//             curve: Curves.easeIn,
//           );
//       update();
//       print(newPageIndex);
//     }
//   }
// }
