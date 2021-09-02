import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/person_detail_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

class PersonOverviewView extends StatelessWidget {
  const PersonOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PersonDetailController>(
      init: Get.find<PersonDetailController>(tag: context.read<String>()),
      builder: (_) {
        //desktop
        if (size.width > 1280.0) {
          return Container(
            child: Text("desktop"),
          );
        }
        //tablet
        else if (size.width > 768.0) {
          return Container(
            child: Text("tablet"),
          );
        }
        //mobile
        else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Section(
                  child: Container(
                    height: size.height * 0.2,
                    width: double.infinity,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 1 / 1.5,
                            child: _.personDetails.profilePath == null
                                ? Image.asset(
                                    'assets/images/no_image_placeholder.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    ImageUrl.getProfileImageUrl(
                                      url:
                                          _.personDetails.profilePath as String,
                                      size: ProfileSizes.w342,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    _.personDetails.name,
                                    style:
                                        Theme.of(context).textTheme.headline5,

                                    // style: TextStyle(
                                    //   color: Colors.white,
                                    //   fontSize: 30.0,
                                    // ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Known for " +
                                            _.personDetails.knownForDepartment,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        // style: TextStyle(
                                        //   color: Colors.grey,
                                        // ),
                                      ),
                                      _.personDetails.birthday != null
                                          ? Text(
                                              ", Age: " + _.getAge().toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,

                                              // style: TextStyle(
                                              //   color: Colors.grey,
                                              // ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                _.personDetails.birthday != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Born: " +
                                                    _.getBirthday()! +
                                                    _.getBirthPlace(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,

                                                // style: TextStyle(
                                                //   color: Colors.grey,
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                                _.personDetails.deathday != null
                                    ? Text(
                                        "Died: " + _.getDeathDay()!,
                                        style:
                                            Theme.of(context).textTheme.caption,

                                        // style: TextStyle(
                                        //   color: Colors.grey,
                                        // ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Section(
                  //isFirst: true,
                  sectionTitle: "Biography",
                  child: Text(
                    _.personDetails.biography,
                    style: Theme.of(context).textTheme.caption,
                    // style: TextStyle(
                    //   color: Colors.white,
                    // ),
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
