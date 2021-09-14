import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/services/network/enums/api_versions.dart';
import 'package:watched_it_getx/app/data/services/network/enums/request_methods.dart';
import 'package:watched_it_getx/app/data/services/network/enums/resource_types.dart';
import 'package:watched_it_getx/app/data/services/network/query_builder.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';

class AccountV3 with QueryBuilder {
  static const apiVersion = ApiVersion.V3;

  ///this method allows you to change movie/tv show favourite status,
  ///pass desired favourite status as favourite variable,
  ///pass userID from v3 api,
  ///if you wish to notify user about response status set showSnackbar to true,
  static Future<bool> markAsFavourite(
    MediaType mediaType,
    String sessionID, {
    required String mediaID,
    required String userID,
    required bool favourite,
    bool showSnackBar = true,
  }) async {
    Map<String, dynamic>? result = await QueryBuilder.executeQuery(
        ResourceType.account, "$userID/favorite",
        httpMethod: HttpMethod.POST,
        queryParameters: {
          "session_id": sessionID,
        },
        body: {
          "media_type": describeEnum(mediaType),
          "media_id": mediaID,
          "favorite": favourite,
        });

    if (showSnackBar)
      Get.snackbar(
        "${describeEnum(mediaType).capitalizeFirst} adding to favourites",
        "${result == null ? 'Unsuccessfully' : 'Successfully'} added to favourites",
      );

    return result != null;
  }

  ///this method allows you to change movie/tv show watchlist status,
  ///pass desired watchlist status as watchlist variable,
  ///pass userID from v3 api,
  ///if you wish to notify user about response status set showSnackbar to true,
  static Future<bool> addToWatchlist(
    MediaType mediaType,
    String sessionID, {
    required String userID,
    required String mediaID,
    required bool watchlist,
    bool showSnackBar = true,
  }) async {
    Map<String, dynamic>? result = await QueryBuilder.executeQuery(
        ResourceType.account, "$userID/watchlist",
        httpMethod: HttpMethod.POST,
        queryParameters: {
          "session_id": sessionID,
        },
        body: {
          "media_type": describeEnum(mediaType),
          "media_id": mediaID,
          "watchlist": watchlist,
        });

    if (showSnackBar)
      Get.snackbar(
        "${describeEnum(mediaType).capitalizeFirst} Watchlist",
        "${result == null ? 'Unsuccessfully' : 'Successfully'} added to watchlist",
      );

    return result != null;
  }
}
