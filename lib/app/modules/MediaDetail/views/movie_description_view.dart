import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/movie_overview_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/similar_movies_view.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/media_review_view.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/widgets/movie_details.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/widgets/swipeable_image_view_f.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/swipeable_image_view_f_controller.dart';

//TODO SWITCH THIS LONG COLUMN WITH TABVIEW (THIS COULD ALSO LEAD TO SMALLER AMOUNT OF REQUESTS)
class MovieDescriptionView extends GetView<MovieOverviewController> {
  const MovieDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: controller.openMediaRatingDialog,
            child: Icon(
              Icons.star,
            ),
          ),
          backgroundColor: Color(0xFF1c1d25),
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
                  text: "Overview",
                ),
                Tab(
                  text: "Overview",
                ),
                Tab(
                  text: "Similar",
                ),
                Tab(
                  text: "Reviews",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Obx(
                      () => AnimatedContainer(
                        height: controller.swipeableController.value == null
                            ? 200
                            : 300,
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
                                        init: controller
                                            .swipeableController.value,
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
                                            tag: controller
                                                .minimalMedia.value.title,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                              child: Image.network(
                                                ImageUrl.getPosterImageUrl(
                                                  url: controller
                                                      .minimalMedia
                                                      .value
                                                      .posterPath as String,
                                                  size: PosterSizes.w342,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => controller
                                                      .accountStates.value ==
                                                  null
                                              ? Container()
                                              : Positioned(
                                                  //alignment: Alignment.bottomRight,
                                                  bottom: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () => controller
                                                        .addToFavourites(),
                                                    child: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20),
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .favorite_rounded,
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
                                          () => controller
                                                      .accountStates.value ==
                                                  null
                                              ? Container()
                                              : Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () => controller
                                                        .addToWatchlist(),
                                                    child: ClipPath(
                                                      clipper: TabClip(),
                                                      child: Container(
                                                        width: 40.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: controller.movie.value ==
                                                  null
                                              ? []
                                              : [
                                                  FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      controller.movie.value
                                                          ?.title as String,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 400,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                    padding: EdgeInsets.only(
                                                        top: 10),
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
              Text("2"),
              SimilarMoviesView(),
              MediaReviewView(),
            ],
          ),
        ),
      ),
    );
  }
}

class TabClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    // path.lineTo(0, size.height);
    // path.lineTo(0, 0);
    // path.lineTo(size.width / 2, size.height / 3);
    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);

    // path.lineTo(0, 0);
    // path.lineTo(size.width / 2, size.height / 3);
    // path.lineTo(size.width, 0);

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 4 * 3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    //path.lineTo();

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
