import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/posterlistview.dart';
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
                  height: 300.0,
                  listTitle: "Now Playing Movies",
                  objects: controller.nowPlayingMovies
                      .map(
                        (element) => PosterListviewObject(
                          id: element.id,
                          mediaType: element.mediaType,
                          title: element.title,
                          subtitle: element.subtitle,
                          imagePath: element.posterPath == null ||
                                  element.posterPath == ""
                              ? null
                              : ImageUrl.getPosterImageUrl(
                                  url: element.posterPath as String,
                                ),
                        ),
                      )
                      .toList(),
                ),
                PosterListView(
                  height: 300.0,
                  listTitle: "Popular Tv Shows",
                  objects: controller.popularTvShows
                      .map(
                        (element) => PosterListviewObject(
                          id: element.id,
                          mediaType: element.mediaType,
                          title: element.title,
                          subtitle: element.subtitle,
                          imagePath: element.posterPath == null ||
                                  element.posterPath == ""
                              ? null
                              : ImageUrl.getPosterImageUrl(
                                  url: element.posterPath as String,
                                ),
                        ),
                      )
                      .toList(),
                ),
                PosterListView(
                  height: 300.0,
                  listTitle: "Popular People",
                  objects: controller.popularPeople
                      .map(
                        (element) => PosterListviewObject(
                          id: element.id,
                          mediaType: element.mediaType,
                          title: element.title,
                          subtitle: element.subtitle,
                          imagePath: element.posterPath == null ||
                                  element.posterPath == ""
                              ? null
                              : ImageUrl.getPosterImageUrl(
                                  url: element.posterPath as String,
                                ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        });
  }
}
