import 'package:flutter/foundation.dart';

class ImageUrl {
  static String baseImagePath = "https://image.tmdb.org/t/p/";
  static String _gravatarPath = "https://www.gravatar.com/avatar/";

  static String getBackdropImageUrl(
          {BackdropSizes size = BackdropSizes.w300, required String url}) =>
      "${baseImagePath}${describeEnum(size)}${url}";

  static String getLogoImageUrl(
          {LogoSizes size = LogoSizes.w300, required String url}) =>
      "${baseImagePath}${describeEnum(size)}${url}";

  static String getPosterImageUrl(
          {PosterSizes size = PosterSizes.w500, required String url}) =>
      "${baseImagePath}${describeEnum(size)}${url}";

  static String getProfileImageUrl(
          {ProfileSizes size = ProfileSizes.w185, required String url}) =>
      "${baseImagePath}${describeEnum(size)}${url}";

  static String getGravatarUrl({required String hash, String size = "300"}) =>
      "${_gravatarPath}${hash}?s=${size}";
}

enum BackdropSizes {
  w300,
  w780,
  w1280,
  original,
}

enum LogoSizes {
  w45,
  w92,
  w154,
  w185,
  w300,
  w500,
  original,
}

enum PosterSizes {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original,
}

enum ProfileSizes {
  w45,
  w185,
  w342,
  w500,
  w780,
  original,
}
