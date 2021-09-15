import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/discover_sorting_options.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/movie/movie_recommendations_model.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_similar_shows.dart';
import 'package:watched_it_getx/app/data/services/network/version3/account.dart';
import 'package:watched_it_getx/app/data/services/network/version4/account.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';
import 'package:watched_it_getx/app/shared_widgets/swipeable_stack/swipe_directions.dart';

class DiscoverViewController extends GetxController {
  List<Widget> objects = [];

  List<RecommendedMovie> movieRecommendations = [];
  List<SimilarTv> tvRecommendations = [];

  Rx<MediaType> selectedMediaType = Rx<MediaType>(MediaType.movie);

  int moviesPage = 1;
  int tvPage = 1;

  late int moviesTotalAmountOfPages;
  late int tvTotalAmountOfPages;

  Rx<String?> currentPosterUrl = Rx<String?>(null);

  int currentMovieIndex = 0;
  int currentTvIndex = 0;

  @override
  void onInit() {
    // print(Get.find<UserService>().accessToken);
    // print(Get.find<UserService>().accountIDv4);
    getMovieRecommendations();
    super.onInit();
  }

  Future<void> getMovieRecommendations() async {
    MovieRecommendations? temp =
        await AccountV4.getPersonalMovieRecommendations(
      accessToken: Get.find<UserService>().accessToken,
      accountID: Get.find<UserService>().accountIDv4,
      page: moviesPage,
    );

    if (temp != null) {
      if (moviesPage == 1) moviesTotalAmountOfPages = temp.totalPages;
      movieRecommendations.addAll(temp.results);
      temp.results.forEach(
        (element) {
          objects.add(
            element.posterPath == null
                ? Image.asset("assets/images/no_image_placeholder.png")
                : Image.network(
                    ImageUrl.getPosterImageUrl(url: element.posterPath!),
                  ),
          );
        },
      );
      changeBackgroundUrl();
    }

    update();
  }

  void changeBackgroundUrl() {
    if (selectedMediaType == MediaType.movie &&
        currentMovieIndex < objects.length) {
      currentPosterUrl.value =
          movieRecommendations[currentMovieIndex].posterPath == null
              ? null
              : ImageUrl.getPosterImageUrl(
                  url: movieRecommendations[currentMovieIndex].posterPath!);
    } else if (selectedMediaType == MediaType.tv &&
        currentTvIndex < objects.length) {
      currentPosterUrl.value =
          tvRecommendations[currentTvIndex].posterPath == null
              ? null
              : ImageUrl.getPosterImageUrl(
                  url: tvRecommendations[currentTvIndex].posterPath!);
    }
  }

  Future<void> getTvRecommendations() async {
    SimilarTvShows? temp = await AccountV4.getPersonalTvRecommendations(
      accessToken: Get.find<UserService>().accessToken,
      accountID: Get.find<UserService>().accountIDv4,
      page: tvPage,
    );

    if (temp != null) {
      if (tvPage == 1) tvTotalAmountOfPages = temp.totalPages;
      tvRecommendations.addAll(temp.results);
      temp.results.forEach(
        (element) {
          objects.add(
            element.posterPath == null
                ? Image.asset("assets/images/no_image_placeholder.png")
                : Image.network(
                    ImageUrl.getPosterImageUrl(url: element.posterPath!),
                  ),
          );
        },
      );
    }

    update();
  }

  void changeDiscoverMedia(MediaType mediaType) async {
    objects.clear();
    if (mediaType != selectedMediaType) {
      if (selectedMediaType == MediaType.movie) {
        selectedMediaType.value = MediaType.tv;
        if (tvRecommendations.length == 0)
          await getTvRecommendations();
        else
          tvRecommendations.forEach(
            (i) => objects.add(
              i.posterPath == null
                  ? Image.asset("assets/images/no_image_placeholder.png")
                  : Image.network(
                      ImageUrl.getPosterImageUrl(url: i.posterPath!),
                    ),
            ),
          );
      } else {
        selectedMediaType.value = MediaType.movie;
        if (movieRecommendations.length == 0)
          await getMovieRecommendations();
        else
          movieRecommendations.forEach(
            (i) => objects.add(
              i.posterPath == null
                  ? Image.asset("assets/images/no_image_placeholder.png")
                  : Image.network(
                      ImageUrl.getPosterImageUrl(url: i.posterPath!),
                    ),
            ),
          );
      }
      changeBackgroundUrl();
      update();
    }
  }

  Future<void> getMoreObjects() async {
    print("getting more");
    if (selectedMediaType == MediaType.movie) {
      if (moviesPage + 1 <= moviesTotalAmountOfPages) {
        moviesPage++;
        await getMovieRecommendations();
      }
    } else if (selectedMediaType == MediaType.tv) {
      if (tvPage + 1 <= tvTotalAmountOfPages) {
        tvPage++;
        await getTvRecommendations();
      }
    }
    update();
  }

  void changeStackObjectIndex(int i) {
    print(i);
    if (selectedMediaType == MediaType.movie) {
      if (currentMovieIndex + 1 == objects.length - 3) getMoreObjects();
      currentMovieIndex = i;
    } else if (selectedMediaType == MediaType.tv) {
      if (currentTvIndex + 1 == objects.length - 3) getMoreObjects();
      currentTvIndex = i;
    }
    changeBackgroundUrl();
  }

  int get currentStackObjectIndex =>
      selectedMediaType == MediaType.movie ? currentMovieIndex : currentTvIndex;

  void handleSwipe(SwipeDirection dir) {
    //adding to favourites
    if (dir == SwipeDirection.Right) {
      AccountV3.markAsFavourite(
        selectedMediaType.value,
        Get.find<UserService>().sessionID,
        mediaID: selectedMediaType.value == MediaType.movie
            ? movieRecommendations[currentMovieIndex].id.toString()
            : tvRecommendations[currentTvIndex].id.toString(),
        userID: Get.find<UserService>().user.id.toString(),
        favourite: true,
      );
    } else if (dir == SwipeDirection.Top) {
      AccountV3.addToWatchlist(
        selectedMediaType.value,
        Get.find<UserService>().sessionID,
        mediaID: selectedMediaType.value == MediaType.movie
            ? movieRecommendations[currentMovieIndex].id.toString()
            : tvRecommendations[currentTvIndex].id.toString(),
        userID: Get.find<UserService>().user.id.toString(),
        watchlist: true,
      );
    } else {
      print("skipping");
    }
  }

  void getToMediaDetailsPage(int i) {
    Get.toNamed(
      "/MediaDetails/${describeEnum(selectedMediaType)}",
      preventDuplicates: false,
      arguments: MinimalMedia(
          id: selectedMediaType.value == MediaType.movie
              ? movieRecommendations[i].id
              : tvRecommendations[i].id,
          mediaType: selectedMediaType.value,
          title: selectedMediaType.value == MediaType.movie
              ? movieRecommendations[i].title
              : tvRecommendations[i].title,
          posterPath: selectedMediaType.value == MediaType.movie
              ? movieRecommendations[i].posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(
                      url: movieRecommendations[i].posterPath!)
              : tvRecommendations[i].posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(
                      url: tvRecommendations[i].posterPath!)),
    );
  }
}
