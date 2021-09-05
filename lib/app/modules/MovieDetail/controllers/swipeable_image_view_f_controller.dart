import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SwipeableWidgetViewController extends GetxController {
  SwipeableWidgetViewController({
    required this.urls,
  });

  final List<String> urls;
  RxInt activeIndex = 0.obs;
  bool swipedLeft = false;

  String getActiveUrl() {
    return urls[activeIndex.value];
  }

  void next() {
    if (activeIndex.value + 1 < urls.length)
      activeIndex.value += 1;
    else
      activeIndex.value = 0;

    update();
  }

  void previous() {
    if (activeIndex.value - 1 >= 0)
      activeIndex.value -= 1;
    else
      activeIndex.value = urls.length - 1;
    update();
  }

  void handleSwipe(DragUpdateDetails data) {
    if (data.delta.dx > 0) {
      //swiping right
      swipedLeft = true;
    } else if (data.delta.dx < 0) {
      //swiping left
      swipedLeft = false;
    }
  }

  void handleSwipeEnd(DragEndDetails data) {
    if (swipedLeft == false) {
      //swiping right
      next();
    } else if (swipedLeft) {
      //swiping left
      previous();
    }
  }
}
