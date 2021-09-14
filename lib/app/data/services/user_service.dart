import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

///make sure to run getUserInfo method before navigating to mainpageview
class UserService extends GetxService {
  UserService({
    required this.sessionID,
    required this.accessToken,
    required this.accountIDv4,
  });

  final String accessToken;
  final String sessionID;
  late final AppUser user;
  final String accountIDv4;

  Future<bool> getUserInfo() async {
    AppUser? tempUser = await TMDBApiService.getUserDetails(sessionID);
    if (tempUser != null) {
      user = tempUser;
      return true;
    }

    return false;
  }
}
