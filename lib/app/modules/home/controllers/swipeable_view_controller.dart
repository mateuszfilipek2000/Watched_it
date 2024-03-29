import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/enums/time_window.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

class SwipeableViewController extends GetxController {
  RxList<MinimalMedia> objects = RxList<MinimalMedia>();
  RxInt currentlyActiveObject = RxInt(0);
  bool wasLastSwipeLeft = false;
  late RestartableTimer objectIncrementTimer;

  Rx<PageController> pageController = PageController().obs;

  @override
  void onInit() async {
    objectIncrementTimer = RestartableTimer(
      Duration(seconds: 5),
      () => nextObject(),
    );
    _getTrendingObjects();
    super.onInit();
  }

  void _getTrendingObjects() async {
    List<MinimalMedia>? results = await TMDBApiService.getPopular(
      mediaType: MediaType.all,
      timeWindow: TimeWindow.day,
      numberOfResults: 5,
    );

    if (results != null)
      for (MinimalMedia result in results) objects.add(result);
    print("asd");
  }

  String getActiveObjectPosterUrl() => ImageUrl.getPosterImageUrl(
        url: objects[currentlyActiveObject.value].posterPath as String,
      );

  String getActiveObjectBackdropUrl() => ImageUrl.getBackdropImageUrl(
        url: objects[currentlyActiveObject.value].backdropPath as String,
        size: BackdropSizes.w780,
      );
  String getActiveObjectTitle() => objects[currentlyActiveObject.value].title;

  List<Widget> getNavigationBar({double dotSize = 15.0}) {
    List<Widget> results = [];
    for (int i = 0; i < objects.length; i++) {
      results.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color:
                  i == currentlyActiveObject.value ? Colors.white : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return results;
  }

  void handleSwipe(DragUpdateDetails data) {
    if (data.delta.dx > 0) {
      //swiping right
      wasLastSwipeLeft = true;
    } else if (data.delta.dx < 0) {
      //swiping left
      wasLastSwipeLeft = false;
    }
  }

  void handleSwipeEnd(DragEndDetails data) {
    if (wasLastSwipeLeft == false) {
      //swiping right
      nextObject();
    } else if (wasLastSwipeLeft) {
      //swiping left
      previousObject();
    }
  }

  void nextObject() {
    if (currentlyActiveObject.value + 1 < objects.length)
      currentlyActiveObject.value += 1;
    else
      currentlyActiveObject.value = 0;
    objectIncrementTimer.reset();
  }

  void previousObject() {
    if (currentlyActiveObject.value - 1 >= 0)
      currentlyActiveObject.value -= 1;
    else
      currentlyActiveObject.value = objects.length - 1;
    objectIncrementTimer.reset();
  }

  void handlePageChange(int page) {
    currentlyActiveObject.value = page;
  }
}
