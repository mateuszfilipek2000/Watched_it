import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/tv/seasons/tv_season_account_states.dart';
import 'package:watched_it_getx/app/data/models/tv/seasons/tv_season_aggregated_credits.dart';
import 'package:watched_it_getx/app/data/models/tv/seasons/tv_season_details.dart';
import 'package:watched_it_getx/app/data/models/tv/seasons/tv_season_images.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_detail_controller.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_episode_detail_view.dart';
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';

class TvSeasonsController extends GetxController {
  TvSeasonsController({required this.tag});
  final String tag;
  //final TvSeasonImages tvSeasonImages;

  RxBool isReady = false.obs;

  RxMap<int, TvSeasonInfo> seasonsInfo = RxMap<int, TvSeasonInfo>({});

  @override
  void onInit() {
    super.onInit();
  }

  void retrieveInfo(int seasonIndex) async {
    if (seasonsInfo[seasonIndex] == null) {
      Map<String, dynamic>? result =
          await TMDBApiService.getAggregatedTvSeasonInfo(
        id: Get.find<TvDetailController>(tag: tag).tvShow!.id,
        sessionID: Get.find<TvDetailController>(tag: tag).sessionID,
        seasonNumber: seasonIndex + 1,
      );
      if (result != null) {
        late TvSeasonDetails? tempDetails;
        late TvSeasonAccountStates? tempTvSeasonAccountStates;
        late TvSeasonAggregatedCredits? tempTvSeasonAggregateCredits;

        if (result["TvSeasonDetails"] != null)
          tempDetails = result["TvSeasonDetails"];
        if (result["TvSeasonAccountStates"] != null)
          tempTvSeasonAccountStates = result["TvSeasonAccountStates"];
        if (result["TvSeasonAggregatedCredits"] != null)
          tempTvSeasonAggregateCredits = result["TvSeasonAggregatedCredits"];

        if (tempDetails != null &&
            tempTvSeasonAccountStates != null &&
            tempTvSeasonAggregateCredits != null) {
          seasonsInfo[seasonIndex] = TvSeasonInfo(
            details: tempDetails,
            tvSeasonAccountStates: tempTvSeasonAccountStates,
            tvSeasonAggregateCredits: tempTvSeasonAggregateCredits,
          );
        }
      }
    } else {
      print("???");
    }
  }

  void getToEpisodeDetails(
      {required int seasonNumber, required int episodeNumber}) {
    Get.to(
      () => TvEpisodeDetailView(tag: tag),
      arguments: {
        "tag": tag,
        "episode_number": episodeNumber,
        "season_number": seasonNumber,
      },
      fullscreenDialog: true,
      preventDuplicates: false,
    );
  }

  void rateEpisode(
      {required int seasonNumber,
      required int seasonIndex,
      required int episodeNumber}) {
    RxDouble rating = seasonsInfo[seasonIndex]!
                .tvSeasonAccountStates
                .episodeRatings[episodeNumber]
                .rated ==
            null
        ? 0.0.obs
        : (seasonsInfo[seasonIndex]!
                .tvSeasonAccountStates
                .episodeRatings[episodeNumber]
                .rated as double)
            .obs;

    Get.defaultDialog(
      title:
          "How'd you rate: ${seasonsInfo[seasonIndex]!.details.name} S${seasonNumber.addLeadingZeros(2)}E${episodeNumber.addLeadingZeros(2)}?",
      content: Obx(
        () => Column(
          children: [
            Slider.adaptive(
              min: 0.0,
              max: 10.0,
              divisions: 20,
              label: rating.value.toString(),
              onChanged: (newRating) => rating.value = newRating,
              value: rating.value,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  "Your rating: ${rating.value.toString()}",
                ),
              ),
            ),
          ],
        ),
      ),
      onConfirm: () {
        print("yeah!");
        rate(
          seasonNumber: seasonNumber,
          episodeNumber: episodeNumber,
          rating: rating.value,
          seasonIndex: seasonIndex,
        );
        Get.back();
      },
      onCancel: () {},
    );
  }

  void rate({
    required int seasonNumber,
    required int episodeNumber,
    required int seasonIndex,
    required double rating,
  }) async {
    bool result = await TMDBApiService.rateTvEpisode(
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      id: Get.find<TvDetailController>(tag: tag).tvShow!.id,
      rating: rating,
      mediaName:
          "${seasonsInfo[seasonIndex]!.details.name} S${seasonNumber.addLeadingZeros(2)}E${episodeNumber.addLeadingZeros(2)}?",
      sessionID: Get.find<TvDetailController>(tag: tag).sessionID,
    );
    if (result)
      getAccountStates(
        seasonNumber: seasonNumber,
        seasonIndex: seasonIndex,
      );
  }

  getAccountStates({
    required int seasonNumber,
    required int seasonIndex,
  }) async {
    TvSeasonAccountStates? temp = await TMDBApiService.getTvSeasonAccountStates(
      id: Get.find<TvDetailController>(tag: tag).tvShow!.id.toString(),
      seasonNumber: seasonNumber,
      sessionID: Get.find<TvDetailController>(tag: tag).sessionID,
    );

    if (temp != null) {
      seasonsInfo[seasonIndex]!.tvSeasonAccountStates = temp;
      update();
    }
  }
}

class TvSeasonInfo {
  TvSeasonInfo({
    required this.details,
    required this.tvSeasonAccountStates,
    required this.tvSeasonAggregateCredits,
  });
  final TvSeasonDetails details;
  TvSeasonAccountStates tvSeasonAccountStates;
  final TvSeasonAggregatedCredits tvSeasonAggregateCredits;
}
