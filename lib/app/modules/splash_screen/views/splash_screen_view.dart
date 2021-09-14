import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

import '../controllers/splash_screen_controller.dart';

//TODO: ADD LOGIN BUTTON MOVE LOGIC TO CONTROLLER

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(
            () => controller.mostPopularMoviePosterURL.value == ""
                ? Container()
                : Opacity(
                    opacity: controller.opacity.value,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            controller.mostPopularMoviePosterURL.value,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => controller.login(),
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
