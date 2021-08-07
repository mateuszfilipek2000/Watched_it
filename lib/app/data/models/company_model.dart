// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);';
import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

class Company {
  Company({
    this.description,
    this.headquarters,
    this.homepage,
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
    this.parentCompany,
  });

  final String? description;
  final String? headquarters;
  final String? homepage;
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;
  final dynamic parentCompany;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        description: json["description"],
        headquarters: json["headquarters"],
        homepage: json["homepage"],
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
        parentCompany: json["parent_company"],
      );
}
