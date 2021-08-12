import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/bindings/media_description_binding.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/media_description_view.dart';

//TODO change swipe up scale to opacity
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
  RxBool shouldBeScrollable = false.obs;
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
  double maxSwipeIndicatorScale = 2.0;
  RxDouble swipeIndicatorOpacity = 1.0.obs;
  //RxBool isBottomSheetVisible = false.obs;
  double _currentDragDistance = 0.0;
  double _dragTreshold = 100.0;
  RxBool isCurrentlyDragged = false.obs;

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
      }
    }

    print(swipeIndicatorPadding.value);
    if (_currentDragDistance >= _dragTreshold) {
      handleDragEnd();
      Get.to(
        () => MediaDescriptionView(),
        binding: MediaDescriptionBinding(),
        fullscreenDialog: true,
        duration: Duration(milliseconds: 500),
        transition: Transition.fadeIn,
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
    slideAnimationController.reset();

    slideAnimation =
        Tween<double>(begin: swipeIndicatorPadding.value, end: 0.0).animate(
      CurvedAnimation(
        parent: slideAnimationController,
        curve: Curves.easeIn,
      ),
    )..addListener(() {
            swipeIndicatorPadding.value = slideAnimation.value;
          });
    slideAnimationController.forward();
    //swipeIndicatorPadding.value = 0;
  }
}
