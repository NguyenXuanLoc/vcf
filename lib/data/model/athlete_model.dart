// To parse this JSON data, do
//
//     final athleteModel = athleteModelFromJson(jsonString);

import 'dart:convert';

List<AthleteModel> athleteModelFromJson(List<dynamic> str) =>
    List<AthleteModel>.from(str.map((x) => AthleteModel.fromJson(x)));

String athleteModelToJson(List<AthleteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AthleteModel {
  dynamic world;
  String? federationId;
  String? photo;
  String? description;
  String? licenseYear;
  String? firstName;
  String? middleName;
  String? lastName;
  String? preferredFirstName;
  dynamic preferredMiddleName;
  String? preferredLastName;
  String? tvFirstName;
  dynamic tvMiddleName;
  String? tvLastName;
  String? gender;
  DateTime? birthDate;
  dynamic nationality;
  String? addressOne;
  dynamic addressTwo;
  String? zip;
  String? city;
  dynamic state;
  String? country;
  String? homePhone;
  dynamic workPhone;
  dynamic mobile;
  dynamic email;
  dynamic facebook;
  String? isFeatureAthlete;
  int? score;

  AthleteModel({
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

  factory AthleteModel.fromJson(Map<String, dynamic> json) => AthleteModel(
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
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
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
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
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
