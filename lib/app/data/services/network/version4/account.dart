import 'package:watched_it_getx/app/data/enums/discover_sorting_options.dart';
import 'package:watched_it_getx/app/data/models/movie/movie_recommendations_model.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_similar_shows.dart';
import 'package:watched_it_getx/app/data/services/network/enums/api_versions.dart';
import 'package:watched_it_getx/app/data/services/network/enums/resource_types.dart';
import 'package:watched_it_getx/app/data/services/network/query_builder.dart';

class AccountV4 with QueryBuilder {
  static const apiVersion = ApiVersion.V4;

  static Future<MovieRecommendations?> getPersonalMovieRecommendations({
    required String accessToken,
    required String accountID,
    DiscoverMovieSortingOptions sortingOption =
        DiscoverMovieSortingOptions.VoteAverageDescending,
    int page = 1,
  }) async {
    Map<String, dynamic>? result = await QueryBuilder.executeQuery(
      ResourceType.account,
      "$accountID/movie/recommendations",
      queryParameters: {
        "page": page.toString(),
        "sort_by": discoverMovieSortingOptionsValues[sortingOption],
      },
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      apiVersion: apiVersion,
    );

    if (result != null) return MovieRecommendations.fromJson(result);

    return null;
  }

  static Future<SimilarTvShows?> getPersonalTvRecommendations({
    required String accessToken,
    required String accountID,
    DiscoverTvSortingOptions sortingOption =
        DiscoverTvSortingOptions.VoteAverageDescending,
    int page = 1,
  }) async {
    Map<String, dynamic>? result = await QueryBuilder.executeQuery(
        ResourceType.account, "$accountID/tv/recommendations",
        queryParameters: {
          "page": page.toString(),
          "sort_by": discoverMovieSortingOptionsValues[sortingOption],
        },
        headers: {
          "Authorization": "Bearer $accessToken",
        });

    if (result != null) return SimilarTvShows.fromJson(result);

    return null;
  }
}
