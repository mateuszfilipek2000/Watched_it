import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/bindings/media_poster_view_binding.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/media_poster_view.dart';
import 'package:watched_it_getx/app/modules/home/controllers/home_controller.dart';

//DONE: FIX NULL ERROR ON NETWORK IMAGE FETCH SOMEWHERE IDK GOOD LUCK PROBABLY WHEN MINIMALMEDIA OBJECT HAS NULL POSTERPATH (ILLEGAL STRING CAST?)
//TODO: CREATE DARK THEME NO IMAGE PLACEHOLDER
class PosterListView extends StatelessWidget {
  const PosterListView({
    Key? key,
    required this.listTitle,
    this.height = 300.0,
    required this.objects,
  }) : super(key: key);

  final List<MinimalMedia> objects;
  final String listTitle;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          this.listTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: objects.length,
              itemBuilder: (context, index) {
                return PosterListViewItem(
                  object: objects[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PosterListViewItem extends StatelessWidget {
  const PosterListViewItem({
    Key? key,
    required this.object,
  }) : super(key: key);

  final MinimalMedia object;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => MediaPosterView(),
            binding: MediaDetailBinding(),
            arguments: object,
            fullscreenDialog: true,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF151515),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1.86,
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    child: AspectRatio(
                      aspectRatio: 1.0 / 1.5,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: object.posterPath == null
                            ? Center(
                                child: Image.asset(
                                  'assets/images/no_image_placeholder.png',
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.network(
                                  ImageUrl.getPosterImageUrl(
                                    url: object.posterPath as String,
                                    size: PosterSizes.w342,
                                  ),
                                  //fit: BoxFit.fill,
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
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          object.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Get.find<HomeController>().getFormattedDate(object),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white30),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({
    Key? key,
    required this.object,
  }) : super(key: key);

  final MinimalMedia object;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FutureBuilder(
        future: TMDBApiService.getMovieDetails(object.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Container();
            default:
              return Container();
          }
        },
      ),
    ]);
  }
}
