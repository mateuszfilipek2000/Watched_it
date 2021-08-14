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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // bottomNavigationBar: Container(
        //   color: Colors.transparent,
        //   child: NavigationBar(
        //     onTap: (int id) {},
        //   ),
        // ),
        bottomNavigationBar: Material(
          color: Color(0xFF151515),
          child: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 3.0,
              ),
              insets: EdgeInsets.only(bottom: 45),
            ),
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home_rounded,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search_rounded,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.explore_rounded,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.account_box_rounded,
                ),
              ),
            ],
          ),
        ),
        //backgroundColor: Color(0xFF171721),
        //backgroundColor: Colors.grey,
        backgroundColor: Color(0xFF1c1d25),
        //backgroundColor: Color(0xFF181920),

        // body: PageView(
        //   controller: controller.pageController.value,
        //   children: [
        //     HomeView(),
        //     SearchPageView(),
        //     Container(
        //       child: Center(
        //         child: Text("3"),
        //       ),
        //     ),
        //     UserPageView(),
        //   ],
        // ),
        body: TabBarView(
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
      ),
    );
  }
}
