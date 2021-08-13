import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/movie_description_controller.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDescriptionController>(
      builder: (_) {
        return Column(
          children: [
            Column(
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.getDateString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    ),
                    BulletSeparator(
                      radius: 4,
                    ),
                    Text(
                      movie.genresCommaSeparated(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      movie.overview,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Obx(
                () => _.credits.value == null
                    ? Container()
                    : PosterListView(
                        listTitle: "Cast",
                        height: 300.0,
                        objects: _.minimalMediaFromCast(),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Obx(
                () => _.credits.value == null
                    ? Container()
                    : PosterListView(
                        listTitle: "Crew",
                        height: 300.0,
                        objects: _.minimalMediaFromCrew(),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PosterListView extends StatelessWidget {
  const PosterListView({
    Key? key,
    required this.height,
    required this.objects,
    required this.listTitle,
  }) : super(key: key);

  final double height;
  final List<MinimalMedia> objects;
  final String listTitle;

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
                      child: Text(
                        listTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
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
                  title: objects[index].title,
                  subtitle: objects[index].subtitle as String,
                  imagePath: objects[index].posterPath == null
                      ? null
                      : ImageUrl.getProfileImageUrl(
                          url: objects[index].posterPath as String,
                          size: ProfileSizes.w342,
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BulletSeparator extends StatelessWidget {
  const BulletSeparator({
    Key? key,
    required this.radius,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }
}

class PosterListViewItem extends StatelessWidget {
  const PosterListViewItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5.0,
        right: 5.0,
        top: 5.0,
      ),
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
                      child: imagePath == null
                          ? Center(
                              child: Image.asset(
                                'assets/images/no_image_placeholder.png',
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network(
                                imagePath as String,
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
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Container(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white30,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
