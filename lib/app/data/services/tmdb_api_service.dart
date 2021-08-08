import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:watched_it_getx/app/data/api_keys.dart';
import 'package:watched_it_getx/app/data/enums/available_watchlist_sorting_options.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/enums/time_window.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/media_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/modules/UserPage/controllers/user_page_controller.dart';
import 'package:watched_it_getx/app/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class TMDBApiService {
  static http.Client client = http.Client();

  static Future<bool> authenticateUser({bool rewriteExisting = false}) async {
    final storage = new FlutterSecureStorage();
    var sessionID = await storage.read(key: "session_id");
    // if session id already exists in secure storage and rewriteExisting is set to false, true is returned
    if (sessionID != null && rewriteExisting == false) {
      print("key exists in secure storage");
      //Get.create(() => sessionID);
      //Get.offAllNamed(Routes.HOME);
      return true;
    }
    //creating new request token (valid for 60 minutes)
    http.Response requestToken = await client.get(
      Uri.parse(
          'https://api.themoviedb.org/3/authentication/token/new?api_key=$apiKeyV3'),
    );

    if (requestToken.statusCode == 200) {
      Get.to(
        Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async {
                  if (json.decode(requestToken.body)['request_token'] != null) {
                    http.Response createSession = await client.post(
                      Uri.parse(
                        "https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKeyV3",
                      ),
                      body: {
                        'request_token':
                            json.decode(requestToken.body)['request_token']
                      },
                    );

                    if (createSession.statusCode == 200) {
                      await storage.write(
                        key: "session_id",
                        value: json.decode(createSession.body)['session_id'],
                      );
                      Get.offAllNamed(Routes.HOME);
                    }
                  }
                },
                icon: Icon(Icons.ac_unit_outlined),
              )
            ],
          ),
          body: WebView(
            initialUrl:
                'https://www.themoviedb.org/authenticate/${json.decode(requestToken.body)['request_token']}',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        fullscreenDialog: true,
      );
    }

    return false;
  }

  static Future<String> getMostPopularMoviePosterUrl() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=$apiKeyV3&page=1"),
    );
    if (response.statusCode == 200) {
      print(
        ImageUrl.getPosterImageUrl(
          size: PosterSizes.w780,
          url: json.decode(response.body)["results"][0]["poster_path"],
        ),
      );
      return ImageUrl.getPosterImageUrl(
        size: PosterSizes.w780,
        url: json.decode(response.body)["results"][0]["poster_path"],
      );
    }
    return await "";
  }

  static Future<AppUser?> getUserDetails(String sessionID) async {
    http.Response response = await client.get(
      Uri.parse(
        "https://api.themoviedb.org/3/account?api_key=$apiKeyV3&session_id=$sessionID",
      ),
    );
    //print(response.body);
    if (response.statusCode == 200)
      return userFromJson(response.body);
    else
      return null;
  }

  static Future<List<MinimalMedia>?> getNowPlayingMovies(
      {int page = 1, region = "PL"}) async {
    http.Response response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKeyV3&language=en-US&page=$page&region=$region"));
    List<MinimalMedia> results = [];
    if (response.statusCode == 200) {
      for (dynamic i in json.decode(response.body)['results'])
        results.add(
          MinimalMedia(
            mediaType: MediaType.movie,
            id: i['id'],
            posterPath: i?['poster_path'],
            title: i['original_title'],
            date: DateTime.parse(i?['release_date']),
          ),
        );
      return results;
    } else
      return null;
  }

  static Future<Movie?> getMovieDetails(int id) async {
    http.Response response = await client.get(
      Uri.parse(
        "https://api.themoviedb.org/3/movie/$id?api_key=$apiKeyV3&language=en-US",
      ),
    );

    if (response.statusCode == 200)
      return movieFromJson(response.body);
    else
      return null;
  }

  static Future<List<MinimalMedia>?> getPopularTvShows({int page = 1}) async {
    http.Response response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/popular?api_key=$apiKeyV3&language=en-US&page=$page"));
    List<MinimalMedia> results = [];
    if (response.statusCode == 200) {
      for (dynamic i in json.decode(response.body)['results'])
        results.add(
          MinimalMedia(
            mediaType: MediaType.tv,
            id: i['id'],
            posterPath: i?['poster_path'],
            title: i['name'],
            date: i['first_air_date'] != null
                ? DateTime.parse(i['first_air_date'])
                : null,
          ),
        );
      return results;
    } else
      return null;
  }

  static Future<List<MinimalMedia>?> getPopular({
    required MediaType mediaType,
    TimeWindow timeWindow = TimeWindow.week,
    int? numberOfResults = null,
  }) async {
    http.Response response = await client.get(
      Uri.parse(
        "https://api.themoviedb.org/3/trending/${describeEnum(mediaType)}/${describeEnum(timeWindow)}?api_key=$apiKeyV3",
      ),
    );

    List<MinimalMedia> results = [];
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)['results'];
      for (dynamic i in body) {
        if (i['media_type'] == 'movie')
          results.add(
            MinimalMedia(
              mediaType: mediaType,
              id: i['id'],
              title: i['title'],
              posterPath: i?['poster_path'],
              date: i['release_date'] != null
                  ? DateTime.parse(i['release_date'])
                  : null,
              backdropPath: i?['backdrop_path'],
            ),
          );
        else if (i['media_type'] == 'tv')
          results.add(
            MinimalMedia(
              mediaType: mediaType,
              id: i['id'],
              title: i['name'],
              posterPath: i?['poster_path'],
              date: i['first_air_date'] != null
                  ? DateTime.parse(i['first_air_date'])
                  : null,
              backdropPath: i?['backdrop_path'],
            ),
          );
        else if (i['media_type'] == 'person')
          results.add(MinimalMedia(
              mediaType: mediaType,
              id: i['id'],
              title: i['name'],
              posterPath: i?['profile_path']));
      }
      if (numberOfResults != null && numberOfResults < results.length)
        results.removeRange(numberOfResults, results.length);
      return results;
    } else
      return null;
  }

  static Future<List<MinimalMedia>?> getWatchlist(
      MediaType mediaType,
      AvailableWatchListSortingOptions sortingOption,
      String sessionID,
      String accountID,
      [String language = "en-US",
      int page = 1]) async {
    late String sorting;
    List<MinimalMedia> results = [];
    if (sortingOption == AvailableWatchListSortingOptions.CreatedAtAsc)
      sorting = "created_at.asc";
    else
      sorting = "created_at.desc";
    http.Response response = await client.get(
      Uri.parse(
        "https://api.themoviedb.org/3/account/$accountID/watchlist/${mediaType == MediaType.movie ? describeEnum(mediaType) + 's' : describeEnum(mediaType)}?api_key=$apiKeyV3&language=$language&session_id=$sessionID&sort_by=$sorting&page=$page",
      ),
    );

    if (response.statusCode == 200) {
      print(
        "https://api.themoviedb.org/3/account/$accountID/watchlist/${mediaType == MediaType.movie ? describeEnum(mediaType) + 's' : describeEnum(mediaType)}?api_key=$apiKeyV3&language=$language&session_id=$sessionID&sort_by=$sorting&page=$page",
      );
      //print(response.body);
      for (dynamic i in json.decode(response.body)["results"]) {
        //print(i);
        if (mediaType == MediaType.movie)
          results.add(
            MinimalMedia(
              mediaType: mediaType,
              id: i['id'],
              title: i['title'],
              posterPath: i?['poster_path'],
              date: i['release_date'] != null
                  ? DateTime.parse(i['release_date'])
                  : null,
              backdropPath: i?['backdrop_path'],
            ),
          );
        else if (mediaType == MediaType.tv)
          results.add(
            MinimalMedia(
              mediaType: mediaType,
              id: i['id'],
              title: i['name'],
              posterPath: i?['poster_path'],
              date: i['first_air_date'] != null
                  ? DateTime.parse(i['first_air_date'])
                  : null,
              backdropPath: i?['backdrop_path'],
            ),
          );
      }
      return results;
    } else {
      print(
        "https://api.themoviedb.org/3/account/$accountID/watchlist/${mediaType == MediaType.movie ? describeEnum(mediaType) + 's' : describeEnum(mediaType)}?api_key=$apiKeyV3&language=$language&session_id=$sessionID&sort_by=$sorting&page=$page",
      );
      return null;
    }
  }

  static Future<List<MinimalMedia>?> getFavourites(
      MediaType mediaType,
      AvailableWatchListSortingOptions sortingOption,
      String sessionID,
      String accountID,
      [String language = "en-US",
      int page = 1]) async {
    late String sorting;
    List<MinimalMedia> results = [];
    if (sortingOption == AvailableWatchListSortingOptions.CreatedAtAsc)
      sorting = "created_at.asc";
    else
      sorting = "created_at.desc";
    http.Response response = await client.get(
      Uri.parse(
        "https://api.themoviedb.org/3/account/$accountID/favorite/${mediaType == MediaType.movie ? describeEnum(mediaType) + 's' : describeEnum(mediaType)}?api_key=$apiKeyV3&session_id=$sessionID&language=$language&sort_by=$sorting&page=$page",
      ),
    );

    if (response.statusCode == 200) {
      for (dynamic i in json.decode(response.body)["results"]) {
        if (mediaType == MediaType.movie)
          results.add(
            MinimalMedia(
              mediaType: mediaType,
              id: i['id'],
              title: i['title'],
              posterPath: i?['poster_path'],
              date: i['release_date'] != null
                  ? DateTime.parse(i['release_date'])
                  : null,
              backdropPath: i?['backdrop_path'],
            ),
          );
        else if (mediaType == MediaType.tv)
          results.add(
            MinimalMedia(
              mediaType: mediaType,
              id: i['id'],
              title: i['name'],
              posterPath: i?['poster_path'],
              date: i['first_air_date'] != null
                  ? DateTime.parse(i['first_air_date'])
                  : null,
              backdropPath: i?['backdrop_path'],
            ),
          );
      }
      return results;
    } else {
      print(
        "https://api.themoviedb.org/3/account/$accountID/favorite/${mediaType == MediaType.movie ? describeEnum(mediaType) + 's' : describeEnum(mediaType)}?api_key=$apiKeyV3&session_id=$sessionID&language=$language&sort_by=$sorting&page=$page",
      );
      return null;
    }
  }
}
