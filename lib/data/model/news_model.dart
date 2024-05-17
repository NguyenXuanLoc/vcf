// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(List<dynamic> str) =>
    List<NewsModel>.from(str.map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? image;
  String? sponsor;
  List<Category>? categories;
  DateTime? createdAt;
  DateTime? updatedAt;

  NewsModel({
    this.id,
    this.name,
    this.slug,
    this.sponsor,
    this.description,
    this.image,
    this.categories,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        sponsor: json["sponsor"],
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "image": image,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Category {
  int? id;
  Name? name;
  Slug? slug;
  String? url;
  String? description;

  Category({
    this.id,
    this.name,
    this.slug,
    this.url,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        slug: slugValues.map[json["slug"]]!,
        url: json["url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "slug": slugValues.reverse[slug],
        "url": url,
        "description": description,
      };
}

enum Name { COMMERCIAL, ELECTRONIC, FASHION }

final nameValues = EnumValues({
  "Commercial": Name.COMMERCIAL,
  "Electronic": Name.ELECTRONIC,
  "Fashion": Name.FASHION
});

enum Slug { COMMERCIAL, ELECTRONIC, FASHION }

final slugValues = EnumValues({
  "commercial": Slug.COMMERCIAL,
  "electronic": Slug.ELECTRONIC,
  "fashion": Slug.FASHION
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
