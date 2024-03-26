class UserModel {
  String? email;
  LatLong? latLong;
  String? name;
  String? phone;
  String? profileImage;
  String? uid;
  String? address;
  String? type;
  String? fcmToken;

  UserModel({
    this.email,
    this.latLong,
    this.name,
    this.phone,
    this.profileImage,
    this.uid,
    this.type,
    this.address,
    this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        latLong:
            json["latLong"] == null ? null : LatLong.fromJson(json["latLong"]),
        name: json["name"],
        phone: json["phone"],
        profileImage: json["profileImage"],
        uid: json["uid"],
        type: json['type'],
        fcmToken: json['fcmToken'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "latLong": latLong?.toJson(),
        "name": name,
        "phone": phone,
        "fcmToken": fcmToken,
        "profileImage": profileImage,
        "uid": uid,
        "type": type,
        'address': address
      };
}

class LatLong {
  double? latitude;
  double? longitude;

  LatLong({
    this.latitude,
    this.longitude,
  });

  factory LatLong.fromJson(Map<String, dynamic> json) => LatLong(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
  @override
  String toString() {
    return 'Lat: $latitude, Long: $longitude';
  }
}
