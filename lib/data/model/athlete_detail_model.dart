// To parse this JSON data, do
//
//     final athleteDetailModel = athleteDetailModelFromJson(jsonString);

import 'dart:convert';

AthleteDetailModel athleteDetailModelFromJson(String str) =>
    AthleteDetailModel.fromJson(json.decode(str));

String athleteDetailModelToJson(AthleteDetailModel data) =>
    json.encode(data.toJson());

class AthleteDetailModel {
  int? id;
  dynamic world;
  String? federationId;
  dynamic photo;
  String? description;
  String? licenseYear;
  String? firstName;
  String? middleName;
  String? lastName;
  dynamic preferredFirstName;
  dynamic preferredMiddleName;
  dynamic preferredLastName;
  dynamic tvFirstName;
  dynamic tvMiddleName;
  dynamic tvLastName;
  String? gender;
  dynamic birthDate;
  dynamic nationality;
  dynamic addressOne;
  dynamic addressTwo;
  dynamic zip;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic homePhone;
  dynamic workPhone;
  dynamic mobile;
  dynamic email;
  dynamic facebook;
  String? isFeatureAthlete;
  int? score;

  AthleteDetailModel({
    this.id,
    this.world,
    this.federationId,
    this.photo,
    this.description,
    this.licenseYear,
    this.firstName,
    this.middleName,
    this.lastName,
    this.preferredFirstName,
    this.preferredMiddleName,
    this.preferredLastName,
    this.tvFirstName,
    this.tvMiddleName,
    this.tvLastName,
    this.gender,
    this.birthDate,
    this.nationality,
    this.addressOne,
    this.addressTwo,
    this.zip,
    this.city,
    this.state,
    this.country,
    this.homePhone,
    this.workPhone,
    this.mobile,
    this.email,
    this.facebook,
    this.isFeatureAthlete,
    this.score,
  });

  factory AthleteDetailModel.fromJson(Map<String, dynamic> json) =>
      AthleteDetailModel(
        id: json["id"],
        world: json["world"],
        federationId: json["federation_id"],
        photo: json["photo"],
        description: json["description"],
        licenseYear: json["license_year"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        preferredFirstName: json["preferred_first_name"],
        preferredMiddleName: json["preferred_middle_name"],
        preferredLastName: json["preferred_last_name"],
        tvFirstName: json["tv_first_name"],
        tvMiddleName: json["tv_middle_name"],
        tvLastName: json["tv_last_name"],
        gender: json["gender"],
        birthDate: json["birth_date"],
        nationality: json["nationality"],
        addressOne: json["address_one"],
        addressTwo: json["address_two"],
        zip: json["zip"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        homePhone: json["home_phone"],
        workPhone: json["work_phone"],
        mobile: json["mobile"],
        email: json["email"],
        facebook: json["facebook"],
        isFeatureAthlete: json["is_feature_athlete"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "world": world,
        "federation_id": federationId,
        "photo": photo,
        "description": description,
        "license_year": licenseYear,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "preferred_first_name": preferredFirstName,
        "preferred_middle_name": preferredMiddleName,
        "preferred_last_name": preferredLastName,
        "tv_first_name": tvFirstName,
        "tv_middle_name": tvMiddleName,
        "tv_last_name": tvLastName,
        "gender": gender,
        "birth_date": birthDate,
        "nationality": nationality,
        "address_one": addressOne,
        "address_two": addressTwo,
        "zip": zip,
        "city": city,
        "state": state,
        "country": country,
        "home_phone": homePhone,
        "work_phone": workPhone,
        "mobile": mobile,
        "email": email,
        "facebook": facebook,
        "is_feature_athlete": isFeatureAthlete,
        "score": score,
      };
}
