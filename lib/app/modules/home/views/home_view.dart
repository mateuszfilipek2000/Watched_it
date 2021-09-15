import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/posterlistview.dart';
import 'package:watched_it_getx/app/modules/home/widgets/swipeable_image_view.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

import '../controllers/home_controller.dart';
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Section(
                  fullWidth: true,
                  fullHeight: true,
                  child: SwipeableImageView(
                    height: 300.0,
                  ),
                ),
                Section(
                  sectionTitle: "Now playing movies",
                  child: PosterListView(
                    height: 300.0,
                    objects: controller.nowPlayingMovies
                        .map(
                          (element) => PosterListviewObject(
                            id: element.id,
                            mediaType: element.mediaType,
                            title: element.title,
                            subtitle: element.date == null
                                ? null
                                : element.date!.getDashedDate(),
                            imagePath: element.posterPath == null ||
                                    element.posterPath == ""
                                ? null
                                : ImageUrl.getPosterImageUrl(
                                    url: element.posterPath!,
                                  ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Section(
                  sectionTitle: "Popular Tv Shows",
                  child: PosterListView(
                    height: 300.0,
                    objects: controller.popularTvShows
                        .map(
                          (element) => PosterListviewObject(
                            id: element.id,
                            mediaType: element.mediaType,
                            title: element.title,
                            subtitle: element.date == null
                                ? null
                                : element.date!.getDashedDate(),
                            imagePath: element.posterPath == null ||
                                    element.posterPath == ""
                                ? null
                                : ImageUrl.getPosterImageUrl(
                                    url: element.posterPath!,
                                  ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Section(
                  sectionTitle: "Trending People",
                  child: PosterListView(
                    height: 300.0,
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
                                    url: element.posterPath!,
                                  ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
