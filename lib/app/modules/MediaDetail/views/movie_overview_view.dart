import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/movie_overview_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/widgets/movie_details.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/widgets/swipeable_image_view_f.dart';

class MovieOverviewView extends StatelessWidget {
  const MovieOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieOverviewController>(
      init: MovieOverviewController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Obx(
              () => AnimatedContainer(
                height:
                    controller.swipeableController.value == null ? 200 : 300,
                duration: Duration(milliseconds: 200),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Obx(
                      () => controller.swipeableController.value != null
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: GetBuilder(
                                init: controller.swipeableController.value,
                                builder: (_) => SwipeableWidgetView(
                                  height: 250,
                                  navigationIndicatorAlignment:
                                      Alignment.topRight,
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
                          AspectRatio(
                            aspectRatio: 1 / 1.5,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Hero(
                                    tag: controller.minimalMedia.value.title,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30),
                                      ),
                                      child: Image.network(
                                        ImageUrl.getPosterImageUrl(
                                          url: controller.minimalMedia.value
                                              .posterPath as String,
                                          size: PosterSizes.w342,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => controller.accountStates.value == null
                                      ? Container()
                                      : Positioned(
                                          //alignment: Alignment.bottomRight,
                                          bottom: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () =>
                                                controller.addToFavourites(),
                                            child: Container(
                                              width: 40.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.favorite_rounded,
                                                  size: 20.0,
                                                  color: controller
                                                          .accountStates
                                                          .value
                                                          ?.favourite as bool
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                Obx(
                                  () => controller.accountStates.value == null
                                      ? Container()
                                      : Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () =>
                                                controller.addToWatchlist(),
                                            child: ClipPath(
                                              clipper: TabClip(),
                                              child: Container(
                                                width: 40.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: controller
                                                          .accountStates
                                                          .value
                                                          ?.watchlist as bool
                                                      ? Colors.blue
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
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
                                                fontSize: 400,
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
