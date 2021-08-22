// class WatchProviders {
//   WatchProviders({
//     required this.id,
//     required this.results,
//   });

//   final int id;
//   final Results results;

//   factory WatchProviders.fromJson(Map<String, dynamic> json) => WatchProviders(
//         id: json["id"],
//         results: Results.fromJson(json["results"]),
//       );
// }

// class Results {
//   Results({
//     required this.ar,
//     required this.at,
//     required this.au,
//     required this.be,
//     required this.br,
//     required this.ca,
//     required this.ch,
//     required this.cl,
//     required this.co,
//     required this.cz,
//     required this.de,
//     required this.dk,
//     required this.ec,
//     required this.es,
//     required this.fi,
//     required this.fr,
//     required this.gb,
//     required this.hu,
//     required this.ie,
//     required this.resultsIn,
//     required this.it,
//     required this.jp,
//     required this.mx,
//     required this.nl,
//     required this.no,
//     required this.nz,
//     required this.pe,
//     required this.pl,
//     required this.pt,
//     required this.ro,
//     required this.ru,
//     required this.se,
//     required this.tr,
//     required this.us,
//     required this.ve,
//     required this.za,
//   });

//   final Ar ar;
//   final At at;
//   final At au;
//   final Ar be;
//   final Ar br;
//   final At ca;
//   final At ch;
//   final Ar cl;
//   final Ar co;
//   final Ar cz;
//   final At de;
//   final At dk;
//   final Ar ec;
//   final Ar es;
//   final At fi;
//   final At fr;
//   final At gb;
//   final Ar hu;
//   final At ie;
//   final Ar resultsIn;
//   final At it;
//   final At jp;
//   final At mx;
//   final Ar nl;
//   final At no;
//   final Ar nz;
//   final Ar pe;
//   final At pl;
//   final Ar pt;
//   final Ar ro;
//   final Ru ru;
//   final At se;
//   final Ar tr;
//   final At us;
//   final Ar ve;
//   final Ar za;

//   factory Results.fromJson(Map<String, dynamic> json) => Results(
//         ar: Ar.fromJson(json["AR"]),
//         at: At.fromJson(json["AT"]),
//         au: At.fromJson(json["AU"]),
//         be: Ar.fromJson(json["BE"]),
//         br: Ar.fromJson(json["BR"]),
//         ca: At.fromJson(json["CA"]),
//         ch: At.fromJson(json["CH"]),
//         cl: Ar.fromJson(json["CL"]),
//         co: Ar.fromJson(json["CO"]),
//         cz: Ar.fromJson(json["CZ"]),
//         de: At.fromJson(json["DE"]),
//         dk: At.fromJson(json["DK"]),
//         ec: Ar.fromJson(json["EC"]),
//         es: Ar.fromJson(json["ES"]),
//         fi: At.fromJson(json["FI"]),
//         fr: At.fromJson(json["FR"]),
//         gb: At.fromJson(json["GB"]),
//         hu: Ar.fromJson(json["HU"]),
//         ie: At.fromJson(json["IE"]),
//         resultsIn: Ar.fromJson(json["IN"]),
//         it: At.fromJson(json["IT"]),
//         jp: At.fromJson(json["JP"]),
//         mx: At.fromJson(json["MX"]),
//         nl: Ar.fromJson(json["NL"]),
//         no: At.fromJson(json["NO"]),
//         nz: Ar.fromJson(json["NZ"]),
//         pe: Ar.fromJson(json["PE"]),
//         pl: At.fromJson(json["PL"]),
//         pt: Ar.fromJson(json["PT"]),
//         ro: Ar.fromJson(json["RO"]),
//         ru: Ru.fromJson(json["RU"]),
//         se: At.fromJson(json["SE"]),
//         tr: Ar.fromJson(json["TR"]),
//         us: At.fromJson(json["US"]),
//         ve: Ar.fromJson(json["VE"]),
//         za: Ar.fromJson(json["ZA"]),
//       );
// }

// class Ar {
//   Ar({
//     required this.link,
//     required this.flatrate,
//   });

//   final String link;
//   final List<Flatrate> flatrate;

//   factory Ar.fromJson(Map<String, dynamic> json) => Ar(
//         link: json["link"],
//         flatrate: List<Flatrate>.from(
//             json["flatrate"].map((x) => Flatrate.fromJson(x))),
//       );
// }

// class Flatrate {
//   Flatrate({
//     required this.displayPriority,
//     required this.logoPath,
//     required this.providerId,
//     required this.providerName,
//   });

//   final int displayPriority;
//   final String logoPath;
//   final int providerId;
//   final String providerName;

//   factory Flatrate.fromJson(Map<String, dynamic> json) => Flatrate(
//         displayPriority: json["display_priority"],
//         logoPath: json["logo_path"],
//         providerId: json["provider_id"],
//         providerName: json["provider_name"],
//       );
// }

// class At {
//   At({
//     required this.link,
//     required this.buy,
//     required this.flatrate,
//     required this.ads,
//     required this.rent,
//   });

//   final String link;
//   final List<Flatrate> buy;
//   final List<Flatrate> flatrate;
//   final List<Flatrate> ads;
//   final List<Flatrate> rent;

//   factory At.fromJson(Map<String, dynamic> json) => At(
//         link: json["link"],
//         buy: json["buy"] == null
//             ? null
//             : List<Flatrate>.from(json["buy"].map((x) => Flatrate.fromJson(x))),
//         flatrate: List<Flatrate>.from(
//             json["flatrate"].map((x) => Flatrate.fromJson(x))),
//         ads: json["ads"] == null
//             ? null
//             : List<Flatrate>.from(json["ads"].map((x) => Flatrate.fromJson(x))),
//         rent: json["rent"] == null
//             ? null
//             : List<Flatrate>.from(
//                 json["rent"].map((x) => Flatrate.fromJson(x))),
//       );
// }

// class Ru {
//   Ru({
//     required this.link,
//     required this.flatrate,
//     required this.free,
//   });

//   final String link;
//   final List<Flatrate> flatrate;
//   final List<Flatrate> free;

//   factory Ru.fromJson(Map<String, dynamic> json) => Ru(
//         link: json["link"],
//         flatrate: List<Flatrate>.from(
//             json["flatrate"].map((x) => Flatrate.fromJson(x))),
//         free:
//             List<Flatrate>.from(json["free"].map((x) => Flatrate.fromJson(x))),
//       );
// }
