import 'package:hive/hive.dart';
import 'dart:convert';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class UserModel {
  @HiveField(1)
  String? email;
  @HiveField(2)
  LatLng? latLong;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? profileImage;
  @HiveField(6)
  String? uid;
  @HiveField(7)
  String? uType; // New field
  @HiveField(8)
  String? fcmToken; // New field
  @HiveField(9)
  String? address; // New field

  UserModel({
    this.email,
    this.latLong,
    this.name,
    this.phone,
    this.profileImage,
    this.uid,
    this.uType,
    this.fcmToken,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    latLong: json["latLong"] == null
        ? null
        : LatLng.fromJson(json["latLong"]),
    name: json["name"],
    phone: json["phone"],
    profileImage: json["profileImage"],
    uid: json["uid"],
    uType: json["uType"],
    fcmToken: json["fcmToken"],
    address: json["address"], // Assign the value of address
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "latLong": latLong?.toJson(),
    "name": name,
    "phone": phone,
    "profileImage": profileImage,
    "uid": uid,
    "uType": uType,
    "fcmToken": fcmToken,
    "address": address, // Include address in the JSON output
  };
}

@HiveType(typeId: 2)
class LatLng {
  @HiveField(1)
  double? latitude;
  @HiveField(2)
  double? longitude;

  LatLng({
    this.latitude,
    this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}
