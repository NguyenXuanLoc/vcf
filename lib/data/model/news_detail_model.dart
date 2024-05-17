// To parse this JSON data, do
//
//     final newsDetailModel = newsDetailModelFromJson(jsonString);

import 'dart:convert';

NewsDetailModel newsDetailModelFromJson(String str) =>
    NewsDetailModel.fromJson(json.decode(str));

String newsDetailModelToJson(NewsDetailModel data) =>
    json.encode(data.toJson());

class NewsDetailModel {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? content;
  String? image;
  List<Category>? categories;
  DateTime? createdAt;
  DateTime? updatedAt;

  NewsDetailModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.content,
    this.image,
    this.categories,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        content: json["content"],
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
        "content": content,
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
  String? name;
  String? slug;
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
        name: json["name"],
        slug: json["slug"],
        url: json["url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "url": url,
        "description": description,
      };
}
