import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/movie_overview_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/widgets/posterlistview.dart';

//TODO REPLACE POSTER LISTVIEW WITH ONE FROM THIS PAGE WHEN IT'S FINISHED
//TODO ADD WATCH PROVIDERS
class MovieDetails extends StatelessWidget {
  const MovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieOverviewController>(
      builder: (_) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Container(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.genres.length,
                  itemBuilder: (context, index) {
                    //TODO ADD SAERCH BASED ON GENRE ON BUTTON CLICK ??? ADD SEARCH QUERY AS AN ARGUMENT TO SEARCH PAGE ???
                    return SearchTextButton(
                      text: movie.genres[index].name,
                      onPressed: () {},
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Keywords:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => _.keywords.value == null
                        ? Container()
                        : Container(
                            height: 40,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _.keywords.value?.keywords.length,
                              itemBuilder: (context, index) {
                                //TODO ADD SAERCH BASED ON KEYWORD ON BUTTON CLICK ??? ADD SEARCH QUERY AS AN ARGUMENT TO SEARCH PAGE ???
                                return SearchTextButton(
                                  text: _.keywords.value?.keywords[index].name
                                      as String,
                                  onPressed: () {},
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class SearchTextButton extends StatelessWidget {
  const SearchTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: OutlinedButton(
        onPressed: () => onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
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
