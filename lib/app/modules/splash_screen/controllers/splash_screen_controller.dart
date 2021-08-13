import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';
import 'package:watched_it_getx/app/routes/app_pages.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  late Future<String> mostPopularMoviePosterURL;

  late AnimationController controller;
  late AnimationController fadeController;

  late bool isSessionActive;
  @override
  void onInit() {
    mostPopularMoviePosterURL = TMDBApiService.getMostPopularMoviePosterUrl();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    fadeController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );

    //checkForUserSession();

    super.onInit();
  }

  @override
  void onReady() async {
    final storage = new FlutterSecureStorage();
    var sessionID = await storage.read(key: "session_id");

    if (sessionID != null) {
      print("key exists in secure storage $sessionID");
      isSessionActive = true;
    } else
      isSessionActive = false;
    // mostPopularMoviePosterURL.value =
    //     await TMDBApiService.getMostPopularMoviePosterUrl();

    await checkForUserSession();
    super.onReady();
  }

  @override
  void onClose() {
    fadeController.dispose();
    controller.dispose();
  }

  void login() async {
    TMDBApiService.authenticateUser();
    print(isSessionActive);
  }

  Future<bool> checkForUserSession() async {
    final storage = new FlutterSecureStorage();
    var sessionID = await storage.read(key: "session_id");

    if (sessionID != null) {
      print("key exists in secure storage");
      Get.find<UserController>().updateSessionID(sessionID);
      Get.offAllNamed(Routes.MAIN_PAGE_VIEW, arguments: sessionID);
    }
    return false;
  }
}
