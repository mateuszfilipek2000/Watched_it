import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/WatchList/bindings/minimal_media_listview_binding.dart';
import 'package:watched_it_getx/app/modules/WatchList/views/minimal_media_listview.dart';

import '../controllers/user_page_controller.dart';

//TODO MOVE NAVIGATION LOGIC TO CONTROLLER MAYBE?
//TODO FIX BUTTON BACKGROUND COLOR
class UserPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPageController>(
      init: UserPageController(),
      builder: (_) {
        if (_.user == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                ImageUrl.getProfileImageUrl(
                                  url: _.user?.avatar_Path as String,
                                  size: ProfileSizes.w185,
                                ),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  _.user?.name as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  _.user?.username as String,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black26,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: ListTile(
                          leading: Icon(
                            Icons.usb_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "My Watchlists",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.black38,
                          onTap: () => Get.to(
                            () => MinimalMediaListView(),
                            fullscreenDialog: true,
                            binding: MinimalMediaListViewBinding(),
                            arguments: {
                              "user": _.user,
                              "ListTitle": "Your watchlists",
                              "ButtonTexts": ["Movies", "Tv Shows"],
                              "SortingMethodTexts": [
                                "Created At - Ascending",
                                "Created At - Descending",
                              ],
                              "MinimalMediaRetrievalFuture":
                                  TMDBApiService.getWatchlist,
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10, left: 10, top: 10, bottom: 10),
                        child: ListTile(
                          leading: Icon(
                            Icons.usb_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "My Favourites",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.black38,
                          onTap: () => Get.to(
                            () => MinimalMediaListView(),
                            fullscreenDialog: true,
                            binding: MinimalMediaListViewBinding(),
                            arguments: {
                              "user": _.user,
                              "ListTitle": "Your favourites",
                              "ButtonTexts": ["Movies", "Tv Shows"],
                              "SortingMethodTexts": [
                                "Created At - Ascending",
                                "Created At - Descending",
                              ],
                              "MinimalMediaRetrievalFuture":
                                  TMDBApiService.getFavourites,
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
