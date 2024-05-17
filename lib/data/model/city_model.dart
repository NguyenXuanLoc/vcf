// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

List<CityModel> cityModelFromJson(List<dynamic> str) =>
    List<CityModel>.from(str.map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  int? id;
  String? name;
  bool isSelect;

  CityModel({
    this.id,
    this.isSelect = false,
    this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        isSelect: false,
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
