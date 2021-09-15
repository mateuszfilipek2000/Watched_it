import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';
import '../controllers/user_page_controller.dart';

//TODO MOVE NAVIGATION LOGIC TO CONTROLLER MAYBE?
//TODO FIX BUTTON BACKGROUND COLOR
class UserPageView extends StatelessWidget {
  final UserPageController controller = Get.put(UserPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Section(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 100.0,
                  child: ClipOval(
                    child: Image.network(
                      ImageUrl.getProfileImageUrl(
                        url: controller.user.avatar_Path!,
                        size: ProfileSizes.w185,
                      ),
                      loadingBuilder: (BuildContext context, Widget child,
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
                          controller.user.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          controller.user.username,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Section(
            child: Column(
              children: [
                Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: ListTile(
                    leading: Icon(
                      Icons.watch_later_rounded,
                    ),
                    title: Text(
                      "My Watchlists",
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: controller.getToWatchlistPage,
                  ),
                ),
                Divider(
                  height: 20.0,
                ),
                Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: ListTile(
                    leading: Icon(
                      Icons.favorite_rounded,
                    ),
                    title: Text(
                      "My Favourites",
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: controller.getToFavouritesPage,
                  ),
                ),
                Divider(
                  height: 20.0,
                ),
                Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                    ),
                    title: Text(
                      "Settings",
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: controller.getToSettingsPage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
