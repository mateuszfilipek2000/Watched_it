import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/movie_detail_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/image_with_icons.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/swipeable_image_view_f.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/posterlistview.dart';
import 'package:watched_it_getx/app/shared_widgets/searchable_text_button_list.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

class MovieOverviewView extends StatelessWidget {
  MovieOverviewView({
    Key? key,
    //required String tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailController>(
      init: Get.find<MovieDetailController>(
        tag: context.read<String>(),
      ),
      tag: context.read<String>(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Section(
                fullWidth: true,
                fullHeight: false,
                child: AnimatedContainer(
                  height: controller.movieImages == null ? 200 : 300,
                  duration: Duration(milliseconds: 200),
                  child: Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.bottomCenter,
                    children: [
                      controller.doesMovieHaveBackdrops()
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: SwipeableWidgetView(
                                height: 250,
                                navigationIndicatorAlignment:
                                    Alignment.topRight,
                                urls: controller.getBackdropUrls(),
                              ),
                            )
                          : Container(),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.surface,
                              Colors.transparent
                            ],
                            begin: Alignment.center,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Obx(
                              () => ImageWithIcons(
                                imagePath: ImageUrl.getPosterImageUrl(
                                  url: controller.movieDetails.posterPath,
                                ),
                                onBookmarkTap: controller.addToWatchlist,
                                onIconTap: controller.addToFavourites,
                                topIconInactive: Icons.bookmark_add_rounded,
                                topIconActive: Icons.bookmark_added_rounded,
                                bottomIconInactive: Icons.favorite_rounded,
                                bottomIconActive: Icons.favorite_rounded,
                                isTopActive:
                                    controller.accountStates.value.watchlist,
                                isBottomActive:
                                    controller.accountStates.value.favourite,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.movieDetails.title,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: controller.generateRating(),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "${controller.movieDetails.voteAverage}/10",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Section(
                sectionTitle: "Overview",
                child: Text(
                  controller.movieDetails.overview,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Section(
                sectionTitle: "Genres",
                child: SearchableTextButtonList(
                  names: controller.movieDetails.genres
                      .map((e) => e.name)
                      .toList(),
                ),
              ),
              Section(
                sectionTitle: "Cast",
                child: PosterListView(
                  //listTitle: "Cast",
                  height: 270.0,
                  objects: controller.movieCredits.cast
                      .map(
                        (element) => PosterListviewObject(
                          id: element.id,
                          mediaType: MediaType.person,
                          title: element.name,
                          subtitle: element.character,
                          imagePath: element.profilePath == null ||
                                  element.profilePath == ""
                              ? null
                              : ImageUrl.getProfileImageUrl(
                                  url: element.profilePath as String,
                                ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Section(
                sectionTitle: "Crew",
                child: PosterListView(
                  //listTitle: "Crew",
                  height: 270.0,
                  objects: controller.movieCredits.crew
                      .map(
                        (element) => PosterListviewObject(
                          id: element.id,
                          mediaType: MediaType.person,
                          title: element.name,
                          subtitle: element.job,
                          imagePath: element.profilePath == null ||
                                  element.profilePath == ""
                              ? null
                              : ImageUrl.getProfileImageUrl(
                                  url: element.profilePath as String,
                                ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Section(
                sectionTitle: "Keywords",
                child: SearchableTextButtonList(
                    names: controller.movieKeywords.keywords
                        .map((e) => e.name)
                        .toList()),
              ),
            ],
          ),
        );
      },
    );
  }
}
