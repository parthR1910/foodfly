import 'dart:convert';

UserOrdersModel userOrdersModelFromJson(String str) => UserOrdersModel.fromJson(json.decode(str));

String userOrdersModelToJson(UserOrdersModel data) => json.encode(data.toJson());

class UserOrdersModel {
  String? foodId;
  bool? paidOrNot;
  String? uOrderId;
  String? userId;
  int? quantity;
  bool? isDelivered;
  String? dateTime;

  UserOrdersModel({
    this.foodId,
    this.paidOrNot,
    this.uOrderId,
    this.userId,
    this.quantity,
    this.isDelivered,
    this.dateTime
  });

  factory UserOrdersModel.fromJson(Map<String, dynamic> json) => UserOrdersModel(
    foodId: json["foodId"],
    paidOrNot: json["paidOrNot"],
    uOrderId: json["uOrderID"],
    userId: json["userId"],
    quantity: json["quantity"],
    isDelivered: json["isDelivered"],
    dateTime: json["dateTime"],
  );

  Map<String, dynamic> toJson() => {
    "foodId": foodId,
    "paidOrNot": paidOrNot,
    "uOrderID": uOrderId,
    "userId": userId,
    "quantity": quantity,
    "isDelivered": isDelivered,
    "dateTime": dateTime,
  };
}
