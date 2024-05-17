// To parse this JSON data, do
//
//     final raceModel = raceModelFromJson(jsonString);

import 'dart:convert';

List<RaceModel> raceModelFromJson(List<dynamic> str) =>
    List<RaceModel>.from(str.map((x) => RaceModel.fromJson(x)));

String raceModelToJson(List<RaceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RaceModel {
  final int? id;
  final String? description;
  final DateTime? raceDate;
  final String? photo;
  final String? startPoint;
  final String? endPoint;
  final int? price;
  final dynamic numberOfAthletic;
  final int? distance;
  final String? terrain;
  final String? location;
  final String? name;
  final String? sponsor;

  RaceModel(
      {this.id,
      this.name,
      this.description,
      this.raceDate,
      this.photo,
      this.startPoint,
      this.endPoint,
      this.price,
      this.numberOfAthletic,
      this.distance,
      this.terrain,
      this.location,
      this.sponsor});

  factory RaceModel.fromJson(Map<String, dynamic> json) => RaceModel(
        sponsor: json["sponsor"],
        name: json["name"],
        id: json["id"],
        description: json["description"],
        raceDate: json["race_date"] == null
            ? null
            : DateTime.parse(json["race_date"]),
        photo: json["photo"],
        startPoint: json["start_point"],
        endPoint: json["end_point"],
        price: json["price"],
        numberOfAthletic: json["number_of_athletic"],
        distance: json["distance"],
        terrain: json["terrain"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "race_date":
            "${raceDate!.year.toString().padLeft(4, '0')}-${raceDate!.month.toString().padLeft(2, '0')}-${raceDate!.day.toString().padLeft(2, '0')}",
        "photo": photo,
        "start_point": startPoint,
        "end_point": endPoint,
        "price": price,
        "number_of_athletic": numberOfAthletic,
        "distance": distance,
        "terrain": terrain,
        "location": location,
        "sponsor": sponsor,
        "name":name
      };
}
