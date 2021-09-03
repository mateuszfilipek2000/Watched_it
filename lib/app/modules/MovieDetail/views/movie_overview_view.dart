import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/movie_overview_controller.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/swipeable_image_view_f_controller.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/image_with_icons.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/movie_details.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/swipeable_image_view_f.dart';
import 'package:provider/provider.dart';

class MovieOverviewView extends StatelessWidget {
  const MovieOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieOverviewController>(
      init: MovieOverviewController(tag: context.read<int>().toString()),
      tag: context.read<int>().toString(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                              imagePath: controller.movie.value?.posterPath ==
                                      null
                                  ? null
                                  : ImageUrl.getPosterImageUrl(
                                      url: controller.movie.value!.posterPath,
                                    ),
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
            Obx(
              () => controller.movie.value == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MovieDetails(
                        movie: controller.movie.value as Movie,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 4 * 3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
