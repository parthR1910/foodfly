class UserModel {
  final String uid;
  final String? email;
  final String? name;
  final String? profileImg;
  final String? currentLocation;
  final String? phone;


  UserModel(
      {required this.uid, this.email, this.name, this.profileImg, this.currentLocation, this.phone,});


  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      uid: json['Uid'],
      name: json['Name'],
      email: json['Email'],
      profileImg: json['ProfileImage'],
      currentLocation: json['CurrentLocation'],
      phone: json['Phone']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Uid": uid,
      "Name": name,
      "Email": email,
      "ProfileImage": profileImg,
      "CurrentLocation": currentLocation,
      "Phone": phone,
    };
  }
}