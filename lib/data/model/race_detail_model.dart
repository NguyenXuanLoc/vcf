// To parse this JSON data, do
//
//     final raceDetailModel = raceDetailModelFromJson(jsonString);

import 'dart:convert';

RaceDetailModel raceDetailModelFromJson(String str) =>
    RaceDetailModel.fromJson(json.decode(str));

String raceDetailModelToJson(RaceDetailModel data) =>
    json.encode(data.toJson());

class RaceDetailModel {
  final int? id;
  final String? description;
  final DateTime? raceDate;
  final String? photo;
  final String? startPoint;
  final String? endPoint;
  final int? price;
  final int? numberOfAthletic;
  final int? distance;
  final String? terrain;
  final dynamic location;
  bool isSelect;
  final List<RaceDetailModel>? rounds;
  final String? sponsor;
  final String? name;

  RaceDetailModel({
    this.isSelect = false,
    this.id,
    this.description,
    this.sponsor,
    this.raceDate,
    this.photo,
    this.startPoint,
    this.endPoint,
    this.price,
    this.numberOfAthletic,
    this.distance,
    this.terrain,
    this.location,
    this.rounds,
    this.name
  });

  factory RaceDetailModel.fromJson(Map<String, dynamic> json) =>
      RaceDetailModel(
        sponsor: json['sponsor'],
        name: json['name'],
        isSelect: false,
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
        rounds: json["rounds"] == null
            ? []
            : List<RaceDetailModel>.from(
                json["rounds"]!.map((x) => RaceDetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'sponsor': sponsor,
        'name': name,
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
        "rounds": rounds == null
            ? []
            : List<dynamic>.from(rounds!.map((x) => x.toJson())),
      };
}
