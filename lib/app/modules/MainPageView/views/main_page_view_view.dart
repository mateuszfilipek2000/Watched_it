import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/SearchPage/views/search_page_view.dart';
import 'package:watched_it_getx/app/modules/UserPage/views/user_page_view.dart';
import 'package:watched_it_getx/app/modules/home/views/home_view.dart';
import 'package:watched_it_getx/app/modules/home/widgets/navigation_bar.dart';

import '../controllers/main_page_view_controller.dart';

class MainPageViewView extends GetView<MainPageViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: NavigationBar(
          onTap: (int id) {},
        ),
      ),
      //backgroundColor: Color(0xFF171721),
      //backgroundColor: Colors.grey,
      backgroundColor: Color(0xFF1c1d25),
      //backgroundColor: Color(0xFF181920),

      body: PageView(
        controller: controller.pageController.value,
        children: [
          HomeView(),
          SearchPageView(),
          Container(
            child: Center(
              child: Text("3"),
            ),
          ),
          UserPageView(),
        ],
      ),
    );
  }
}
