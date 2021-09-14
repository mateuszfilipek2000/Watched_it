import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/services/network/user_auth.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';
import 'package:watched_it_getx/app/modules/MainPageView/bindings/main_page_view_binding.dart';
import 'package:watched_it_getx/app/modules/MainPageView/views/main_page_view_view.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  RxString mostPopularMoviePosterURL = "".obs;

  //late AnimationController controller;
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  RxDouble opacity = 0.0.obs;
  Tween<double> opacityTween = Tween(begin: 0.0, end: 1.0);
  @override
  void onInit() {
    fadeController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );
    fadeAnimation = opacityTween.animate(fadeController)
      ..addListener(() {
        opacity.value = fadeAnimation.value;
      });

    //checkForUserSession();

    super.onInit();
  }

  @override
  void onReady() async {
    await checkForUserSession();
    getPopularMoviePoster();
    super.onReady();
  }

  void getPopularMoviePoster() async {
    mostPopularMoviePosterURL.value =
        await TMDBApiService.getMostPopularMoviePosterUrl();
    fadeController.forward();
  }

  @override
  void onClose() {
    fadeController.dispose();
    //controller.dispose();
  }

  void login() async {
    //TMDBApiService.authenticateUser();
    UserAuthentication.authenticateUser();
  }

  Future<bool> checkForUserSession() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? accessToken = await storage.read(key: "access_token");
    String? sessionID = await storage.read(key: "session_id");
    String? accountIDv4 = await storage.read(key: "account_id_v4");

    if (sessionID != null && accessToken != null && accountIDv4 != null) {
      Get.put(
        UserService(
          accessToken: accessToken,
          sessionID: sessionID,
          accountIDv4: accountIDv4,
        ),
      );

      bool userInit = await Get.find<UserService>().getUserInfo();

      if (userInit)
        Get.offAll(
          () => MainPageViewView(),
          binding: MainPageViewBinding(),
        );
    }
    return false;
  }
}
