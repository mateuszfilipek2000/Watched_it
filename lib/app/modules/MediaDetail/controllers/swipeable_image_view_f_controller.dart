import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SwipeableWidgetViewController extends GetxController {
  SwipeableWidgetViewController({
    required this.children,
  });

  final List<Widget> children;
  RxInt activeIndex = 0.obs;
  bool swipedLeft = false;

  Widget getActiveChild() => children[activeIndex.value];

  void next() {
    if (activeIndex.value + 1 < children.length)
      activeIndex.value += 1;
    else
      activeIndex.value = 0;

    update();
  }

  void previous() {
    if (activeIndex.value - 1 >= 0)
      activeIndex.value -= 1;
    else
      activeIndex.value = children.length - 1;
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
