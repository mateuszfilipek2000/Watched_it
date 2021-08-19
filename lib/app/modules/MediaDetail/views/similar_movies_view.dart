import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/similar_movies_controller.dart';

class SimilarMoviesView extends StatelessWidget {
  const SimilarMoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SimilarMoviesController>(
      init: SimilarMoviesController(),
      initState: (_) {},
      builder: (_) {
        return Container();
      },
    );
  }
}
