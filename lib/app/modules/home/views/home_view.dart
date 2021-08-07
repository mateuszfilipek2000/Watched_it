import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/home/widgets/poster_listview.dart';
import 'package:watched_it_getx/app/modules/home/widgets/swipeable_image_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SingleChildScrollView(
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
          );
        });
  }
}
