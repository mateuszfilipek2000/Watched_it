import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/WatchList/bindings/watch_list_binding.dart';
import 'package:watched_it_getx/app/modules/WatchList/views/watch_list_view.dart';
import 'package:watched_it_getx/app/shared_widgets/MinimalMediaListView/minimal_media_listview.dart';
import 'package:watched_it_getx/app/shared_widgets/MinimalMediaListView/minimal_media_listview_binding.dart';

import '../controllers/user_page_controller.dart';

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
                            // width: 100.0,
                            // height: 100.0,
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
                            //color: Colors.blue,
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
                  //height: 300.0,
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
                          // onTap: () => Get.to(
                          //   () => WatchListView(),
                          //   binding: WatchListBinding(),
                          //   arguments: _.user,
                          // ),
                          // onTap: () => Get.to(
                          //   () => WatchListView(),
                          //   fullscreenDialog: true,
                          //   binding: WatchListBinding(),
                          //   arguments: _.user,
                          // ),
                          onTap: () => Get.to(
                            () => MinimalMediaListView(),
                            fullscreenDialog: true,
                            binding: MinimalMediaListViewBinding(),
                            arguments: {
                              "user": _.user,
                              "ListTitle": "Your watchlists :))",
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
                        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
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
                              "ListTitle": "Your favourites :)",
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
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10, left: 10, top: 10, bottom: 10),
                        child: ListTile(
                          leading: Icon(
                            Icons.usb_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "My Reviewed",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.black38,
                          onTap: () {},
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

// class WatchListView extends StatelessWidget {
//   const WatchListView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
// return Column(
//   children: [
//     Row(
//       children: [
//         Expanded(
//           flex: 5,
//           child: Obx(
//             () => Row(
//               children: <MediaButton>[
//                 for (var i = 0; i < _.buttonTexts.length; i++)
//                   MediaButton(
//                     color: i == _.activeMediaIndex.value
//                         ? Colors.blue
//                         : Colors.grey,
//                     id: i,
//                     onPressed: _.changeActiveMedia,
//                     text: _.buttonTexts[i],
//                   ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(),
//         ),
//         Expanded(
//           flex: 4,
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: PopupMenuButton(
//               onSelected: (Text text) => _.changeSortingMethod(
//                 int.parse(
//                   text.data as String,
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Sorted By",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       Icon(
//                         Icons.filter_alt_rounded,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                   Obx(() => Text(
//                         _.sortingMethodsTexts[_.activeSortingMethod.value],
//                         style: TextStyle(color: Colors.grey, fontSize: 10),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       )),
//                 ],
//               ),
//               itemBuilder: (context) => <PopupMenuEntry<Text>>[
//                 for (var i = 0; i < _.sortingMethodsTexts.length; i++)
//                   PopupMenuItem(
//                     value: Text(i.toString()),
//                     child: Text(
//                       _.sortingMethodsTexts[i],
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//     Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Divider(
//         height: 2,
//         color: Colors.grey,
//       ),
//     ),
//     Column(
//       children: <Widget>[
//         for (var i = 0; i < _.watchlist.length; i++)
//           Container(
//             height: 50,
//             child: Text(
//               _.watchlist[i].title,
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ),
//           )
//       ],
//     ),
//   ],
// );
//   }
// }


