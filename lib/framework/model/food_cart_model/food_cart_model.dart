import 'dart:convert';

FoodCartModel foodCartModelFromJson(String str) => FoodCartModel.fromJson(json.decode(str));

String foodCartModelToJson(FoodCartModel data) => json.encode(data.toJson());

class FoodCartModel {
  String? foodId;
  bool? paidOrNot;
  String? uOrderId;
  String? userId;
  int? quantity;
  bool? isDelivered;
  String? dateTime;

  FoodCartModel({
    this.foodId,
    this.paidOrNot,
    this.uOrderId,
    this.userId,
    this.quantity,
    this.isDelivered,
    this.dateTime
  });

  factory FoodCartModel.fromJson(Map<String, dynamic> json) => FoodCartModel(
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
