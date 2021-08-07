import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/modules/home/controllers/swipeable_view_controller.dart';
import 'package:watched_it_getx/app/modules/home/widgets/navigation_bar.dart';
import 'package:watched_it_getx/app/modules/home/widgets/poster_listview.dart';
import 'package:watched_it_getx/app/modules/home/widgets/swipeable_image_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
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
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController.value,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SwipeableImageView(
                      height: 300.0,
                    ),
                    PosterListView(
                      listTitle: "Now Playing Movies",
                      objects: controller.nowPlayingMovies,
                    ),
                    PosterListView(
                      listTitle: "Popular Tv Shows",
                      objects: controller.popularTvShows,
                    ),
                    PosterListView(
                      listTitle: "Popular People",
                      objects: controller.popularPeople,
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Text("1"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("2"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("3"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("4"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
