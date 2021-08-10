import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';

class MediaDetailController extends GetxController
    with SingleGetTickerProviderMixin {
  Rx<MinimalMedia?> minimalMedia = Rx<MinimalMedia?>(null);
  late AnimationController animationController;
  late Animation<double> animation;
  RxDouble bgOpacity = 0.0.obs;
  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(
        () {
          bgOpacity.value = animation.value;
        },
      );
    minimalMedia.value = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
  }
}
