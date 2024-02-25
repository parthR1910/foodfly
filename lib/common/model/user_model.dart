class UserModel {
  final int id;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String idProof;
  final String accountNumber;
  final String bankName;
  final String ifscCode;
  final String photo;
  final String address;
  final String pincode;
  final String city;
  final String state;
  final String latLong;
  final String emailAddress;
  final String fcmToken;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.idProof,
    required this.accountNumber,
    required this.bankName,
    required this.ifscCode,
    required this.photo,
    required this.address,
    required this.pincode,
    required this.latLong,
    required this.city,
    required this.state,
    required this.emailAddress,
    required this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      phoneNumber: json['phone_number'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      idProof: json['id_proof'] ?? '',
      accountNumber: json['account_number'] ?? '',
      bankName: json['bank_name'] ?? '',
      ifscCode: json['ifsc_code'] ?? '',
      photo: json['photo'] ?? '',
      latLong: json['latLong']??'',
      address: json['address'] ?? '',
      pincode: json['pincode'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      emailAddress: json['email_address'] ?? '',
      fcmToken: json['fcm_token'] ?? '',
    );
  }
}
