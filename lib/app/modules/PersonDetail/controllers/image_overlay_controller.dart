import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImageOverlayController extends GetxController
    with SingleGetTickerProviderMixin {
  late final AnimationController animController;
  late final Animation<double> animation;

  bool isControllerRunning = false;

  Duration animationDuration = Duration(milliseconds: 300);

  RxDouble animValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    animController = AnimationController(
      vsync: this,
      duration: animationDuration,
    )
      ..addListener(() {
        animValue.value = animController.value;
        //print(animController.value);
        update();
      })
      ..addStatusListener((status) {
        //if (status == AnimationStatus.completed) animController.reverse();
      });

    animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: animController,
        curve: Curves.easeInOutBack,
      ),
    );
    //animation.

    //animController.forward();
  }

  @override
  void onClose() async {
    animController.dispose();
    super.onClose();
  }

  void runAnimationController() async {
    //animController.reset();
    //animController.resync(this);
    animController.forward();
  }

  void reverseAnimationController() {}
}
