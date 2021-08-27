import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';

class PosterListView extends StatelessWidget {
  const PosterListView({
    Key? key,
    required this.height,
    this.width = double.infinity,
    required this.objects,
    required this.listTitle,
  }) : super(key: key);

  final double height;
  final double width;
  final List<PosterListviewObject> objects;
  final String listTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: objects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("tapped ${objects[index].title}");
                    // Get.to(
                    //   () => MovieDetailView(),
                    //   arguments: objects[index],
                    //   fullscreenDialog: true,
                    //   //id: objects[index].id,
                    //   preventDuplicates: false,
                    // );
                    Get.toNamed(
                      "/MediaDetails/${describeEnum(objects[index].mediaType)}",
                      preventDuplicates: false,
                      arguments: MinimalMedia(
                        id: objects[index].id,
                        mediaType: objects[index].mediaType,
                        title: objects[index].title,
                        posterPath: objects[index].imagePath,
                      ),
                    );
                  },
                  child: PosterListViewItem(
                    title: objects[index].title,
                    subtitle: objects[index].subtitle,
                    imagePath: objects[index].imagePath == null
                        ? null
                        : objects[index].imagePath as String,
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

class PosterListViewItem extends StatelessWidget {
  const PosterListViewItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5.0,
        right: 10.0,
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
                        subtitle == null ? "" : subtitle as String,
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
