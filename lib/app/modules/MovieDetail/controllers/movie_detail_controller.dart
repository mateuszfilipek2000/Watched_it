import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/keywords.dart';
import 'package:watched_it_getx/app/data/models/movie/movie_credits_model.dart';
import 'package:watched_it_getx/app/data/models/movie/movie_images.dart';
import 'package:watched_it_getx/app/data/models/movie/movie_model.dart';
import 'package:watched_it_getx/app/data/models/movie/movie_recommendations_model.dart';
import 'package:watched_it_getx/app/data/models/reviews.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/fractionally_coloured_star.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/media_rating.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';

class MovieDetailController extends GetxController {
  late MovieDetails movieDetails;
  late Rx<AccountStates> accountStates;
  late MovieCredits movieCredits;
  late MovieImages? movieImages;
  late Keywords movieKeywords;
  late MovieRecommendations movieRecommendations;
  late MovieRecommendations movieSimilar;
  late Reviews movieReviews;

  bool isReady = false;

  @override
  void onInit() {
    prepareMovieDetailsPage();
    super.onInit();
  }

  void prepareMovieDetailsPage() async {
    Map<String, dynamic>? results = await TMDBApiService.getAggregatedMovie(
      id: Get.arguments.id,
      sessionID: Get.find<UserController>().sessionID.value,
    );

    movieImages = await TMDBApiService.getMovieImages(
      id: Get.arguments.id,
    );

    if (results != null) {
      movieDetails = results["MovieDetails"];
      accountStates = Rx(results["AccountStates"]);
      movieCredits = results["MovieCredits"];
      movieKeywords = results["Keywords"];
      movieRecommendations = results["MovieRecommendations"];
      movieSimilar = results["MovieSimilar"];
      movieReviews = results["Reviews"];
      isReady = true;
      update();
    }
  }

  Future<Reviews?> fetchReviews(int page) => TMDBApiService.getReviews(
        id: Get.arguments.id,
        mediaType: MediaType.movie,
        page: page,
      );

  //check if there are any backdrops in MovieImages before using this function
  List<String> getBackdropUrls() {
    return movieImages?.backdrops
        .map((e) => ImageUrl.getBackdropImageUrl(url: e.filePath))
        .toList() as List<String>;
  }

  bool doesMovieHaveBackdrops() =>
      (movieImages != null || movieImages?.backdrops.length != 0);

  void addToFavourites() async {
    bool status = await TMDBApiService.markAsFavourite(
      accountID: Get.find<UserController>().user.id,
      contentID: movieDetails.id,
      mediaType: MediaType.movie,
      sessionID: Get.find<UserController>().sessionID.value,
      isFavourite: !(accountStates.value.favourite),
    );
    if (status == true) {
      AccountStates? temp = await TMDBApiService.getAccountStates(
        sessionID: Get.find<UserController>().sessionID.value,
        mediaID: movieDetails.id,
        mediaType: MediaType.movie,
      );
      if (temp != null) accountStates.value = temp;
    }
    print(status);
  }

  void addToWatchlist() async {
    bool status = await TMDBApiService.addToWatchlist(
      accountID: Get.find<UserController>().user.id,
      contentID: movieDetails.id,
      mediaType: MediaType.movie,
      sessionID: Get.find<UserController>().sessionID.value,
      add: !(accountStates.value.favourite),
    );
    if (status == true) {
      AccountStates? temp = await TMDBApiService.getAccountStates(
        sessionID: Get.find<UserController>().sessionID.value,
        mediaID: movieDetails.id,
        mediaType: MediaType.movie,
      );
      if (temp != null) accountStates.value = temp;
    }
  }

  List<FractionallyColouredStar> generateRating() {
    List<FractionallyColouredStar> rating = [];
    double mediaRating = (movieDetails.voteAverage) / 2;
    print(mediaRating);
    for (int i = 0; i < 5; i++) {
      if (mediaRating - 1.0 > 0) {
        mediaRating -= 1;
        rating.add(FractionallyColouredStar(fraction: 1));
      } else {
        rating.add(FractionallyColouredStar(fraction: mediaRating));
        mediaRating = 0;
      }
    }
    return rating;
    //return rating.reversed.toList();
  }

  Map<String, List<PosterListviewObject>> getSortingOptionsWithData() {
    final Map<String, List<PosterListviewObject>> results = {};
    if (movieRecommendations.results.length != 0)
      results["Recommended"] = movieRecommendations.results
          .map(
            (e) => PosterListviewObject(
              id: e.id,
              title: e.title,
              mediaType: MediaType.tv,
              subtitle: e.releaseDate.getDashedDate(),
              imagePath: e.posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(url: e.posterPath!),
            ),
          )
          .toList();
    if (movieSimilar.results.length != 0)
      results["Similar"] = movieSimilar.results
          .map(
            (e) => PosterListviewObject(
              id: e.id,
              title: e.title,
              mediaType: MediaType.tv,
              subtitle: e.releaseDate.getDashedDate(),
              imagePath: e.posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(url: e.posterPath!),
            ),
          )
          .toList();
    return results;
  }

  void rateMovie() async {
    if (isReady == true) {
      double? rating = await openMediaRatingDialog(
        title: movieDetails.title,
        rating: accountStates.value.rated,
      );
      if (rating != null) {
        bool success = await rate(
          id: movieDetails.id,
          rating: rating,
          mediaType: MediaType.movie,
          mediaName: movieDetails.title,
          sessionID: Get.find<UserController>().sessionID.value,
        );

        if (success) {
          AccountStates? temp = await TMDBApiService.getAccountStates(
            sessionID: Get.find<UserController>().sessionID.value,
            mediaID: movieDetails.id,
            mediaType: MediaType.movie,
          );
          if (temp != null) accountStates.value = temp;
        }
      }
    }
  }
}
