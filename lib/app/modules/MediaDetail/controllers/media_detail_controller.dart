import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/bindings/movie_description_binding.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/movie_description_view.dart';

//TODO change swipe up scale to opacity
//TODO FIX ANIMATIONS? THEY SOMETIMES WORK JUST FINE IDK WHATS HAPPENING THINK NOT USING GETX FOR ANIMATIONS
class MediaDetailController extends GetxController
    with SingleGetTickerProviderMixin {
  Rx<MinimalMedia?> minimalMedia = Rx<MinimalMedia?>(null);
  late AnimationController animationController;
  late Animation<double> animation;
  RxDouble bgOpacity = 0.0.obs;

  late AnimationController slideAnimationController;
  late Animation<double> slideAnimation;
  Rx<ScrollController> scrollController = Rx<ScrollController>(
    ScrollController(),
  );
  //RxBool shouldBeScrollable = false.obs;
  /*
  when vertical swipe will be detected by gesture detector, the controller
  will keep track of delta y, and change swipe indicator scale 
  and padding accordingly
  the goal here is to achieve a slight upward motion of the swipe indicator
  with increasing padding
  when the maximum value is achieved (of both scale and padding) 
  swipe up action should happen
  */
  RxDouble swipeIndicatorPadding = 0.0.obs;
  double maxSwipeIndicatorPadding = 200.0;
  RxDouble swipeIndicatorOpacity = 1.0.obs;
  double _currentDragDistance = 0.0;
  double _dragTreshold = 100.0;
  //RxBool isCurrentlyDragged = false.obs;

  late AnimationController indicatorOpacityAnimationController;
  late Animation<double> indicatorOpacityAnimation;
  RxDouble indicatorOpacity = 1.0.obs;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    )..addListener(
        () {
          bgOpacity.value = animation.value;
        },
      );
    minimalMedia.value = Get.arguments;

    //slide animation
    slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );
    //indicator opacity animation controller
    indicatorOpacityAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    slideAnimationController.dispose();
    indicatorOpacityAnimationController.dispose();
  }

  void handleDragStart(DragStartDetails details) {
    _currentDragDistance = 0.0;
  }

  //TODO REFACTOR THIS FUNCTION, IT KINDA WORKS?
  void handleDragUpdate(DragUpdateDetails details) {
    double step = details.delta.dy;

    _currentDragDistance -= step;

    //if bottom sheet is visible then the current padding defaults
    //to max padding + x pixels

    if (swipeIndicatorPadding.value - step > 0) {
      if (swipeIndicatorPadding.value - step <= maxSwipeIndicatorPadding) {
        swipeIndicatorPadding.value -= step;

        indicatorOpacity.value += (step / maxSwipeIndicatorPadding);
      }
    }

    //print(swipeIndicatorPadding.value);
    if (_currentDragDistance >= _dragTreshold) {
      handleDragEnd();
      Get.to(
        () => MovieDescriptionView(),
        binding: MovieDescriptionBinding(),
        fullscreenDialog: true,
        duration: Duration(milliseconds: 500),
        transition: Transition.fade,
      );
    }
    //else if (_currentDragDistance <= _dragTreshold * (-1.0) &&
    //     isBottomSheetVisible.value) {
    //   isBottomSheetVisible.value = false;
    //   swipeIndicatorPadding.value = 0.0;
    //   swipeIndicatorOpacity.value = 1.0;
    //   slideAnimationController.reverse();
    // }

    //print(_currentDragDistance);
  }

  void handleDragEnd() {
    print("end" + swipeIndicatorPadding.value.toString());
    slideAnimationController.reset();
    indicatorOpacityAnimationController.reset();

    slideAnimation =
        Tween<double>(begin: swipeIndicatorPadding.value, end: 0.0).animate(
      CurvedAnimation(
        parent: slideAnimationController,
        curve: Curves.easeIn,
      ),
    )..addListener(() {
            print("anim" + swipeIndicatorPadding.value.toString());
            swipeIndicatorPadding.value = slideAnimation.value;
          });

    indicatorOpacityAnimation =
        Tween<double>(begin: indicatorOpacity.value, end: 1.0).animate(
      CurvedAnimation(
        parent: indicatorOpacityAnimationController,
        curve: Curves.easeIn,
      ),
    )..addListener(() {
            indicatorOpacity.value = indicatorOpacityAnimation.value;
          });

    slideAnimationController.forward();
    indicatorOpacityAnimationController.forward();
    //swipeIndicatorPadding.value = 0;
  }
}
