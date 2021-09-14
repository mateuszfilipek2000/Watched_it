import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/discover_sorting_options.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/movie/movie_recommendations_model.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_similar_shows.dart';
import 'package:watched_it_getx/app/data/services/network/version4/account.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';

class DiscoverViewController extends GetxController {
  RxList<Widget> objects = RxList([]);

  List<MovieRecommendations> movieRecommendations = [];
  List<SimilarTvShows> tvRecommendations = [];

  late final List<String> currentOptions;
  int selectedMediaTypeIndex = 0;

  int moviesPage = 1;
  int tvPage = 1;

  @override
  void onInit() {
    print(Get.find<UserService>().accessToken);
    print(Get.find<UserService>().accountIDv4);
    getMovieRecommendations();
    super.onInit();
  }

  void getMovieRecommendations() async {
    // var temp = await TMDBApiService.getPersonalMovieRecommendations(
    //   sortingOption: DiscoverMovieSortingOptions.VoteAverageDescending,
    //   accountID: Get.find<UserService>().accountIDv4,
    //   page: moviesPage,
    // );
    // if (temp != null) {
    //   movieRecommendations.add(temp);
    //   temp.results.forEach(
    //     (element) {
    //       objects.add(
    //         element.posterPath == null
    //             ? Image.asset("assets/images/no_image_placeholder.png")
    //             : Image.network(
    //                 ImageUrl.getPosterImageUrl(url: element.posterPath!),
    //               ),
    //       );
    //     },
    //   );
    // }
    MovieRecommendations? temp =
        await AccountV4.getPersonalMovieRecommendations(
      accessToken: Get.find<UserService>().accessToken,
      accountID: Get.find<UserService>().accountIDv4,
    );

    if (temp != null) {
      movieRecommendations.add(temp);
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

  void getTvRecommendations() async {
    var temp = await TMDBApiService.getPersonalTvRecommendations(
      sortingOption: DiscoverTvSortingOptions.VoteAverageDescending,
      accountID: Get.find<UserService>().user.id.toString(),
      page: tvPage,
    );
    if (temp != null) {
      tvRecommendations.add(temp);
      temp.results.forEach(
        (element) {
          objects.add(element.posterPath == null
              ? Image.asset("assets/images/no_image_placeholder.png")
              : Image.network(element.posterPath!));
        },
      );
    }

    update();
  }
}
