import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/movie_description_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/widgets/movie_details.dart';

class MovieDescriptionView extends GetView<MovieDescriptionController> {
  const MovieDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c1d25),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: controller.movie.value == null
                            ? []
                            : controller.generateRating(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Hero(
                              tag: controller.minimalMedia.value.title,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30)),
                                child: Image.network(
                                  ImageUrl.getPosterImageUrl(
                                    url: controller.minimalMedia.value
                                        .posterPath as String,
                                    size: PosterSizes.w780,
                                  ),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      color: Colors.black,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => controller.accountStates.value == null
                                ? Container()
                                : Positioned(
                                    //alignment: Alignment.bottomRight,
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => controller.addToFavourites(),
                                      child: Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          //shape: BoxShape.circle,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                            topLeft: Radius.circular(30),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite_rounded,
                                            size: 30.0,
                                            color: controller.accountStates
                                                    .value?.favourite as bool
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          Obx(
                            () => controller.accountStates.value == null
                                ? Container()
                                : Positioned(
                                    //alignment: Alignment.bottomRight,
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => controller.addToWatchlist(),
                                      child: Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          //shape: BoxShape.circle,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            //topRight: Radius.circular(30),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.tab_outlined,
                                            size: 30.0,
                                            color: controller.accountStates
                                                    .value?.watchlist as bool
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.movie.value == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MovieDetails(
                          movie: controller.movie.value as Movie,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
