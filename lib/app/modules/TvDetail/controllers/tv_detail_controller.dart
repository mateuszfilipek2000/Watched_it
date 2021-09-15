import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/keywords.dart';
import 'package:watched_it_getx/app/data/models/media_images.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/reviews.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_aggregated_credits.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_details_model.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_similar_shows.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/fractionally_coloured_star.dart';
import 'package:watched_it_getx/app/shared_widgets/media_images_view/media_images_view_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/media_rating.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';

class TvDetailController extends GetxController {
  late AppUser? user;
  late String sessionID;
  Rx<MinimalMedia> minimalMedia = Rx<MinimalMedia>(Get.arguments);

  TvDetails? tvShow = null;
  Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);
  Rx<TvAggregatedCredits?> aggregatedCredits = Rx<TvAggregatedCredits?>(null);
  Keywords? keywords = null;
  Reviews? reviews = null;
  SimilarTvShows? similarTvShows = null;
  SimilarTvShows? recommendedTvShows = null;
  //WatchProviders? watchProviders;

  RxBool isLoading = true.obs;

  Rx<MediaImages?> images = Rx<MediaImages?>(null);

  @override
  void onInit() async {
    // user = await TMDBApiService.getUserDetails(
    //   Get.find<UserController>().sessionID.value,
    // );
    user = await Get.find<UserService>().user;
    sessionID = await Get.find<UserService>().sessionID;
    retrieveData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void retrieveData() async {
    isLoading.value = true;
    Map<String, dynamic>? result = await TMDBApiService.getAggregatedTv(
        id: this.minimalMedia.value.id, sessionID: this.sessionID);

    if (result != null) {
      if (result["Details"] != null) {
        this.tvShow = result["Details"];
      }
      if (result["AccountStates"] != null) {
        this.accountStates.value = result["AccountStates"];
      }
      if (result["AggregateCredits"] != null) {
        this.aggregatedCredits.value = result["AggregateCredits"];
      }
      if (result["Keywords"] != null) {
        this.keywords = result["Keywords"];
      }
      if (result["Reviews"] != null) {
        this.reviews = result["Reviews"];
      }
      if (result["SimilarTvShows"] != null) {
        this.similarTvShows = result["SimilarTvShows"];
      }
      if (result["Recommendations"] != null) {
        this.recommendedTvShows = result["Recommendations"];
      }

      images.value = await TMDBApiService.getMediaImages(
        mediaID: minimalMedia.value.id.toString(),
        mediaType: MediaType.tv,
      );

      isLoading.value = false;
    }
  }

  void addToFavourites() async {
    bool status = await TMDBApiService.markAsFavourite(
      accountID: user?.id as int,
      contentID: minimalMedia.value.id,
      mediaType: minimalMedia.value.mediaType,
      sessionID: sessionID,
      isFavourite: !(accountStates.value?.favourite as bool),
    );
    if (status == true) {
      accountStates.value = await TMDBApiService.getAccountStates(
        sessionID: sessionID,
        mediaID: minimalMedia.value.id,
        mediaType: minimalMedia.value.mediaType,
      );
    }
    print(status);
  }

  void addToWatchlist() async {
    bool status = await TMDBApiService.addToWatchlist(
      accountID: user?.id as int,
      contentID: minimalMedia.value.id,
      mediaType: minimalMedia.value.mediaType,
      sessionID: sessionID,
      add: !(accountStates.value?.watchlist as bool),
    );
    if (status == true) {
      accountStates.value = await TMDBApiService.getAccountStates(
        sessionID: sessionID,
        mediaID: minimalMedia.value.id,
        mediaType: minimalMedia.value.mediaType,
      );
    }
  }

  List<FractionallyColouredStar> generateRating() {
    List<FractionallyColouredStar> rating = [];
    double mediaRating = (tvShow?.voteAverage as double) / 2;
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

  //check if recommended and similar tv shows are provided, if any of them is not provided or empty, then it is not returned
  Map<String, List<PosterListviewObject>> getSortingOptionsWithData() {
    final Map<String, List<PosterListviewObject>> results = {};
    if (recommendedTvShows!.results.length != 0)
      results["Recommended"] = recommendedTvShows!.results
          .map(
            (e) => PosterListviewObject(
              id: e.id,
              title: e.title,
              mediaType: MediaType.tv,
              subtitle:
                  e.releaseDate == null ? null : e.releaseDate!.getDashedDate(),
              imagePath: e.posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(url: e.posterPath!),
            ),
          )
          .toList();
    if (similarTvShows!.results.length != 0)
      results["Similar"] = similarTvShows!.results
          .map(
            (e) => PosterListviewObject(
              id: e.id,
              title: e.title,
              mediaType: MediaType.tv,
              subtitle:
                  e.releaseDate == null ? null : e.releaseDate!.getDashedDate(),
              imagePath: e.posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(url: e.posterPath!),
            ),
          )
          .toList();
    return results;
  }

  void rateTv() async {
    if (isLoading == false) {
      double? rating = await openMediaRatingDialog(
        title: tvShow!.name,
        rating: accountStates.value?.rated,
      );
      if (rating != null) {
        bool success = await rate(
          id: tvShow!.id,
          rating: rating,
          mediaType: MediaType.tv,
          mediaName: tvShow!.name,
          sessionID: Get.find<UserService>().sessionID,
        );

        if (success) {
          AccountStates? temp = await TMDBApiService.getAccountStates(
            sessionID: Get.find<UserService>().sessionID,
            mediaID: tvShow!.id,
            mediaType: MediaType.tv,
          );
          if (temp != null) accountStates.value = temp;
        }
      }
    }
  }

  List<MediaImageObject> getAllImages() {
    List<MediaImageObject> results = [];
    if (images.value != null) {
      images.value!.backdrops.forEach(
        (element) {
          results.add(
            MediaImageObject(
              lowResUrl: ImageUrl.getBackdropImageUrl(
                url: element.filePath,
                size: BackdropSizes.w300,
              ),
              highResUrl: ImageUrl.getBackdropImageUrl(
                url: element.filePath,
                size: BackdropSizes.w780,
              ),
              aspectRatio: element.aspectRatio,
            ),
          );
        },
      );
      images.value!.posters.forEach(
        (element) {
          results.add(
            MediaImageObject(
              lowResUrl: ImageUrl.getPosterImageUrl(
                url: element.filePath,
                size: PosterSizes.w500,
              ),
              highResUrl: ImageUrl.getPosterImageUrl(
                url: element.filePath,
                size: PosterSizes.w780,
              ),
              aspectRatio: element.aspectRatio,
            ),
          );
        },
      );
    }
    results.shuffle();
    return results;
  }
}
