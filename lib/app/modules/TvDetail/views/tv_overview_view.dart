import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/swipeable_image_view_f_controller.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/image_with_icons.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/posterlistview.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/swipeable_image_view_f.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_detail_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/shared_widgets/searchable_text_button_list.dart';

class TvOverviewView extends StatelessWidget {
  TvOverviewView({
    Key? key,
    required String tag,
  })  : controller = Get.find<TvDetailController>(tag: tag),
        super(key: key);

  final TvDetailController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => AnimatedContainer(
              height: controller.images.value == null ? 200 : 300,
              duration: Duration(milliseconds: 200),
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.bottomCenter,
                children: [
                  Obx(
                    () => controller.images.value != null
                        ? GetBuilder(
                            init: SwipeableWidgetViewController(
                              children: controller.images.value
                                  ?.getBackdropImages() as List<Image>,
                            ),
                            tag: context.read<int>().toString(),
                            builder: (_) => Align(
                              alignment: Alignment.topCenter,
                              child: SwipeableWidgetView(
                                height: 250,
                                navigationIndicatorAlignment:
                                    Alignment.topRight,
                                tag: context.read<int>().toString(),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1c1d25), Colors.transparent],
                        begin: Alignment.center,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Obx(
                          () => ImageWithIcons(
                            minimalMedia: controller.minimalMedia.value,
                            onBookmarkTap: controller.addToWatchlist,
                            onIconTap: controller.addToFavourites,
                            topIconInactive: Icons.bookmark_add_rounded,
                            topIconActive: Icons.bookmark_added_rounded,
                            bottomIconInactive: Icons.favorite_rounded,
                            bottomIconActive: Icons.favorite_rounded,
                            isTopActive:
                                controller.accountStates.value?.watchlist,
                            isBottomActive:
                                controller.accountStates.value?.favourite,
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => !(controller.isReady.value)
                                ? Container()
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: controller.tvShow == null
                                          ? []
                                          : [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  controller.tvShow?.name
                                                      as String,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 40,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: controller
                                                      .generateRating(),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  "${controller.tvShow?.voteAverage.toString() as String}/10",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                    ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, top: 20.0),
                child: Text(
                  "Overview:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Obx(
                () {
                  if (controller.isReady.value == false) {
                    return Container();
                  } else
                    return Text(
                      controller.tvShow!.overview,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        //fontWeight: FontWeight.w500,
                      ),
                      //overflow: TextOverflow.ellipsis,
                      //maxLines: 5,
                    );
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, top: 20.0),
                child: Text(
                  "Genres:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Obx(
                () {
                  if (controller.isReady.value == false) {
                    return Container();
                  } else
                    return SearchableTextButtonList(
                        names: controller.tvShow!.genres
                            .map((e) => e.name)
                            .toList());
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Obx(
                  () {
                    if (controller.aggregatedCredits.value == null) {
                      return Container(
                        height: 300.0,
                        width: double.infinity,
                        //color: Colors.black38,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return PosterListView(
                        listTitle: "Cast",
                        height: 300.0,
                        objects: (controller.aggregatedCredits.value
                                ?.minimalMediaFromCast() as List<MinimalMedia>)
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
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Obx(
                  () {
                    if (controller.aggregatedCredits.value == null) {
                      return Container(
                        height: 300.0,
                        width: double.infinity,
                        //color: Colors.black38,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return PosterListView(
                        listTitle: "Crew",
                        height: 300.0,
                        objects: (controller.aggregatedCredits.value
                                ?.minimalMediaFromCrew() as List<MinimalMedia>)
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
                      );
                    }
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, top: 20.0),
                      child: Text(
                        "Keywords:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        if (controller.isReady.value == false) {
                          return Container();
                        } else
                          return SearchableTextButtonList(
                              names: controller.keywords!.keywords
                                  .map((e) => e.name)
                                  .toList());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





/*
Obx(
              () => AnimatedContainer(
                height: controller.images.value == null ? 200 : 300,
                duration: Duration(milliseconds: 200),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Obx(
                      () => controller.images.value != null
                          ? GetBuilder(
                              init: SwipeableWidgetViewController(
                                children: controller.getBackdropImages(),
                              ),
                              tag: context.read<int>().toString(),
                              builder: (_) => Align(
                                alignment: Alignment.topCenter,
                                child: SwipeableWidgetView(
                                  height: 250,
                                  navigationIndicatorAlignment:
                                      Alignment.topRight,
                                  tag: context.read<int>().toString(),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      height: 200,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Obx(
                            () => ImageWithIcons(
                              minimalMedia: controller.minimalMedia.value,
                              onBookmarkTap: controller.addToWatchlist,
                              onIconTap: controller.addToFavourites,
                              topIconInactive: Icons.bookmark_add_rounded,
                              topIconActive: Icons.bookmark_added_rounded,
                              bottomIconInactive: Icons.favorite_rounded,
                              bottomIconActive: Icons.favorite_rounded,
                              isTopActive:
                                  controller.accountStates.value?.watchlist,
                              isBottomActive:
                                  controller.accountStates.value?.favourite,
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: controller.movie.value == null
                                      ? []
                                      : [
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              controller.movie.value?.title
                                                  as String,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children:
                                                  controller.generateRating(),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              "${controller.movie.value?.voteAverage.toString() as String}/10",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                ),
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
*/