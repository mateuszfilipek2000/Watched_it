import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

Future<double?> openMediaRatingDialog({
  required String title,
  double? rating,
}) async {
  late RxDouble _rating;
  if (rating == null || rating < 0.5 || rating > 10.0)
    _rating = 0.5.obs;
  else
    _rating = rating.obs;
  rating = null;
  await Get.defaultDialog(
    title: "How'd you rate: ${title}?",
    content: Obx(
      () => Column(
        children: [
          Slider.adaptive(
            min: 0.5,
            max: 10.0,
            divisions: 19,
            label: _rating.value.toString(),
            onChanged: (newRating) => _rating.value = newRating,
            value: _rating.value,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                "Your rating: ${_rating.value}",
              ),
            ),
          ),
        ],
      ),
    ),
    onConfirm: () {
      // print("yeah!");
      // rate(
      //   id: id,
      // );
      rating = _rating.value;
      Get.back();
    },
    onCancel: () {},
  );
  return rating;
}

Future<bool> rate({
  required int id,
  required double rating,
  required MediaType mediaType,
  required String mediaName,
  required String sessionID,
}) async =>
    await TMDBApiService.rateMedia(
      id: id,
      rating: rating,
      mediaType: mediaType,
      mediaName: mediaName,
      sessionID: sessionID,
    );
