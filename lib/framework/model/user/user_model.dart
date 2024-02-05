

class UserModel {
  final String? email;
  final LatLng? latLong;
  final String? name;
  final String? phone;
  final String? profileImg;
  final String? uid;

  UserModel({
    this.email,
    this.latLong,
    this.name,
    this.phone,
    this.profileImg,
    this.uid,
  });

  // Convert an instance of Temperatures to a Map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'latLong': latLong?.toJson(),
      'name': name,
      'phone': phone,
      'profileImage': profileImg,
      'uid': uid,
    };
  }

  // Create an instance of Temperatures from a Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      latLong: LatLng.fromJson(json['latLong']),
      name: json['name'],
      phone: json['phone'],
      profileImg: json['profileImage'],
      uid: json['uid'],
    );
  }
}

class LatLng {
  final double? latitude;
  final double? longitude;

  LatLng({this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Create an instance of LatLng from a Map
  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }
}