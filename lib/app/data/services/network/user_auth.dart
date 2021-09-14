import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/api_keys.dart';
import 'package:watched_it_getx/app/data/services/network/tmdb_base_network_mixin.dart';
import 'package:http/http.dart' as http;
import 'package:watched_it_getx/app/data/services/user_service.dart';
import 'package:watched_it_getx/app/modules/MainPageView/bindings/main_page_view_binding.dart';
import 'package:watched_it_getx/app/modules/MainPageView/views/main_page_view_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserAuthentication with TmdbBaseNetworkMixin {
  ///if access token and session id is in secure storage then true is returned
  ///if this function returns false then something went wrong
  ///if rewriteExisting is set to true function runs no matter if access token is exisiting
  ///if successful, new request token is generated.
  ///User is then asked to approve it.
  ///If approval is successful then the access token and session id is generated
  static Future<bool> authenticateUser({bool rewriteExisting = false}) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? accessToken = await storage.read(key: "access_token");
    String? sessionID = await storage.read(key: "session_id");
    String? accountIDv4 = await storage.read(key: "account_id");

    if (accessToken != null &&
        rewriteExisting == false &&
        sessionID != null &&
        accountIDv4 != null) {
      print("access token exists in secure storage");
      return true;
    }

    http.Response requestTokenResponse = await TmdbBaseNetworkMixin.client.post(
      Uri.parse("https://api.themoviedb.org/4/auth/request_token"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + apiReadAccessTokenV4,
        HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
      },
      body: json.encode({}),
    );

    if (requestTokenResponse.statusCode == 200) {
      //request token is valid for 15 minutes
      String requestToken =
          json.decode(requestTokenResponse.body)["request_token"];
      Get.to(
        Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () async {
                  //creating access token
                  //if the request is successful user is redirected to MainPageView
                  http.Response accessTokenResponse =
                      await TmdbBaseNetworkMixin.client.post(
                    Uri.parse("https://api.themoviedb.org/4/auth/access_token"),
                    headers: {
                      HttpHeaders.authorizationHeader:
                          "Bearer " + apiReadAccessTokenV4,
                      HttpHeaders.contentTypeHeader:
                          "application/json;charset=utf-8",
                    },
                    body: json.encode({
                      "request_token": requestToken,
                    }),
                  );

                  if (accessTokenResponse.statusCode == 200) {
                    print(accessTokenResponse.body);
                    await storage.write(
                      key: "access_token",
                      value:
                          json.decode(accessTokenResponse.body)["access_token"],
                    );

                    await storage.write(
                      key: "account_id_v4",
                      value:
                          json.decode(accessTokenResponse.body)["account_id"],
                    );

                    //if access token is generated session id is generated from it
                    http.Response sessionResponse =
                        await TmdbBaseNetworkMixin.client.post(
                      Uri.parse(
                          "https://api.themoviedb.org/3/authentication/session/convert/4?api_key=$apiKeyV3"),
                      headers: {
                        HttpHeaders.authorizationHeader:
                            "Bearer " + apiReadAccessTokenV4,
                        HttpHeaders.contentTypeHeader:
                            "application/json;charset=utf-8",
                      },
                      body: json.encode({
                        "access_token": json
                            .decode(accessTokenResponse.body)["access_token"],
                      }),
                    );

                    if (sessionResponse.statusCode == 200) {
                      await storage.write(
                        key: "session_id",
                        value: json.decode(sessionResponse.body)['session_id'],
                      );

                      Get.put(
                        UserService(
                          sessionID:
                              json.decode(sessionResponse.body)['session_id'],
                          accessToken: json
                              .decode(accessTokenResponse.body)["access_token"],
                          accountIDv4: json
                              .decode(accessTokenResponse.body)["account_id"],
                        ),
                      );

                      bool userInit =
                          await Get.find<UserService>().getUserInfo();
                      if (userInit)
                        Get.offAll(
                          () => MainPageViewView(),
                          binding: MainPageViewBinding(),
                        );
                      else {
                        print("can't get user info");
                        Get.back();
                      }
                    }
                  } else {
                    print("failed to create access token");
                    print(accessTokenResponse.statusCode);
                    print(accessTokenResponse.body);
                    Get.back();
                  }
                },
                child: Text("Done"),
              )
            ],
          ),
          body: WebView(
            initialUrl:
                "https://www.themoviedb.org/auth/access?request_token=$requestToken",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        fullscreenDialog: true,
      );
    } else {
      print(requestTokenResponse.statusCode);
      print(requestTokenResponse.body);
    }
    return false;
  }
}
