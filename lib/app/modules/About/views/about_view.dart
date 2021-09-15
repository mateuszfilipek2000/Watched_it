import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Section(
            isFirst: true,
            child: Text(
              "This app is open source, \nthe source code is available at my github at https://github.com/mateuszfilipek2000/Watched_it\nIf you have any questions feel free to open an issue at github project page, thanks for using my app!",
            ),
          ),
          Section(
            child: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    "assets/images/blue_square_tmdb_attribution.png",
                  ),
                ),
                Text(
                  'This product uses the TMDb API but is not endorsed or certified by TMDb.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
