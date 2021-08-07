import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

//TODO: ADD LOGIN BUTTON MOVE LOGIC TO CONTROLLER

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
            future: controller.mostPopularMoviePosterURL,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    color: Colors.black,
                  );
                case ConnectionState.done:
                  controller.fadeController.forward();
                  return FadeTransition(
                    opacity: controller.fadeController
                        .drive(CurveTween(curve: Curves.easeIn)),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            snapshot.data.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                default:
                  return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
