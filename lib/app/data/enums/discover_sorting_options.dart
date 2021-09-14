// enum DiscoverMovieSortingOptions {
//   PopularityAscending,
//   PopularityDescending,
//   ReleaseDateAscending,
//   ReleaseDateDescending,
//   RevenueAscending,
//   RevenueDescending,
//   PrimaryReleaseDateAscending,
//   PrimaryReleaseDateDescending,
//   OriginalTitleAscending,
//   OriginalTitleDescending,
//   VoteAverageAscending,
//   VoteAverageDescending,
//   VoteCountAscending,
//   VoteCountDescending,
// }

// const Map<DiscoverMovieSortingOptions, String> discoverSortingOptionsValues = {
//   DiscoverMovieSortingOptions.PopularityAscending: "popularity.asc",
//   DiscoverMovieSortingOptions.PopularityDescending: "popularity.desc",
//   DiscoverMovieSortingOptions.ReleaseDateAscending: "release_date.asc",
//   DiscoverMovieSortingOptions.ReleaseDateDescending: "release_date.desc",
//   DiscoverMovieSortingOptions.RevenueAscending: "revenue.asc",
//   DiscoverMovieSortingOptions.RevenueDescending: "revenue.desc",
//   DiscoverMovieSortingOptions.PrimaryReleaseDateAscending:
//       "primary_release_date.asc",
//   DiscoverMovieSortingOptions.PrimaryReleaseDateDescending:
//       "primary_release_date.desc",
//   DiscoverMovieSortingOptions.OriginalTitleAscending: "original_title.asc",
//   DiscoverMovieSortingOptions.OriginalTitleDescending: "original_title.desc",
//   DiscoverMovieSortingOptions.VoteAverageAscending: "vote_average.asc",
//   DiscoverMovieSortingOptions.VoteAverageDescending: "vote_average.desc",
//   DiscoverMovieSortingOptions.VoteCountAscending: "vote_count.asc",
//   DiscoverMovieSortingOptions.VoteCountDescending: "vote_count.desc",
// };

enum DiscoverMovieSortingOptions {
  CreatedAtAscending,
  CreatedAtDescending,
  ReleaseDateAscending,
  ReleaseDateDescending,
  TitleAscending,
  TitleDescending,
  VoteAverageAscending,
  VoteAverageDescending,
}

const Map<DiscoverMovieSortingOptions, String>
    discoverMovieSortingOptionsValues = {
  DiscoverMovieSortingOptions.CreatedAtAscending: "created_at.asc",
  DiscoverMovieSortingOptions.CreatedAtDescending: "created_at.desc",
  DiscoverMovieSortingOptions.ReleaseDateAscending: "release_date.asc",
  DiscoverMovieSortingOptions.ReleaseDateDescending: "release_date.desc",
  DiscoverMovieSortingOptions.TitleAscending: "title.asc",
  DiscoverMovieSortingOptions.TitleDescending: "title.desc",
  DiscoverMovieSortingOptions.VoteAverageAscending: "vote_average.asc",
  DiscoverMovieSortingOptions.VoteAverageDescending: "vote_average.desc",
};

enum DiscoverTvSortingOptions {
  FirstAirDateAscending,
  FirstAirDateDescending,
  NameAscending,
  NameDescending,
  TitleAscending,
  TitleDescending,
  ReleaseDateAscending,
  ReleaseDateDescending,
  VoteAverageAscending,
  VoteAverageDescending,
}

const Map<DiscoverTvSortingOptions, String> discoverTvSortingOptionsValues = {
  DiscoverTvSortingOptions.FirstAirDateAscending: "first_air_date.asc",
  DiscoverTvSortingOptions.FirstAirDateDescending: "first_air_date.desc",
  DiscoverTvSortingOptions.ReleaseDateAscending: "release_date.asc",
  DiscoverTvSortingOptions.ReleaseDateDescending: "release_date.desc",
  DiscoverTvSortingOptions.TitleAscending: "title.asc",
  DiscoverTvSortingOptions.TitleDescending: "title.desc",
  DiscoverTvSortingOptions.VoteAverageAscending: "vote_average.asc",
  DiscoverTvSortingOptions.VoteAverageDescending: "vote_average.desc",
  DiscoverTvSortingOptions.NameAscending: "name.asc",
  DiscoverTvSortingOptions.NameDescending: "name.desc",
};
