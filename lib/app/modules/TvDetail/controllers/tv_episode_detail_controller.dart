import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/tv/episodes/tv_episode_account_states.dart';
import 'package:watched_it_getx/app/data/models/tv/episodes/tv_episode_credits.dart';
import 'package:watched_it_getx/app/data/models/tv/episodes/tv_episode_details.dart';
import 'package:watched_it_getx/app/data/models/tv/episodes/tv_episode_images.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_detail_controller.dart';

class TvEpisodeDetailController extends GetxController {
  late int episodeNumber;
  late int seasonNumber;
  late String tag;

  late TvEpisodeDetails details;
  late TvEpisodeAccountStates accountStates;
  late TvEpisodeCredit credits;
  late TvEpisodeImages images;

  RxBool isReady = false.obs;

  @override
  void onInit() {
    episodeNumber = Get.arguments["episode_number"];
    seasonNumber = Get.arguments["season_number"];
    tag = Get.arguments["tag"];
    prepareEpisode();

    super.onInit();
  }

  Future<void> prepareEpisode() async {
    Map<String, dynamic>? result = await TMDBApiService.getAggregatedTvEpisode(
      id: Get.find<TvDetailController>(tag: tag).tvShow!.id,
      sessionID: Get.find<TvDetailController>(tag: tag).sessionID,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
    );

    if (result != null) {
      details = result["TvEpisodeDetails"];
      accountStates = result["TvEpisodeAccountStates"];
      credits = result["TvEpisodeCredits"];
      images = result["TvEpisodeImages"];
      isReady.value = true;
    }
  }

  List<Image> getStillPaths() {
    List<Image> results = [];
    for (Still still in images.stills)
      results.add(
        Image.network(
          ImageUrl.getStillImageUrl(
            url: still.filePath,
            size: StillSizes.w185,
          ),
          fit: BoxFit.cover,
        ),
      );
    return results;
  }
}
