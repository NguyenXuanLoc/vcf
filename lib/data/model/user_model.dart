// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phone;
  String? avatar;
  dynamic dob;
  dynamic gender;
  String? description;
  dynamic uciId;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.dob,
    this.gender,
    this.description,
    this.uciId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        dob: json["dob"],
        gender: json["gender"],
        description: json["description"],
        uciId: json["uci_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "dob": dob,
        "gender": gender,
        "description": description,
        "uci_id": uciId,
      };
}
