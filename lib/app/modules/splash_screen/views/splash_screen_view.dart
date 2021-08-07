import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/splash_screen/views/animated_login_button_view.dart';

import '../controllers/splash_screen_controller.dart';

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
          Center(
            child: AnimatedLoginButtonView(),
          ),
        ],
      ),
    );
  }
}
