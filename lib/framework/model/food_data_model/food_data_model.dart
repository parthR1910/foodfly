import 'dart:convert';

FoodDataModel foodDataModelFromJson(String str) => FoodDataModel.fromJson(json.decode(str));

String foodDataModelToJson(FoodDataModel data) => json.encode(data.toJson());

class FoodDataModel {
  final String? categoryId;
  final String? foodId;
  final String? name;
  final int? price;
  final String? description;
  final String? image;
  final double? tax;
  final double? offPrice;

  FoodDataModel({
    this.categoryId,
    this.foodId,
    this.name,
    this.price,
    this.description,
    this.image,
    this.tax,
    this.offPrice
  });

  factory FoodDataModel.fromJson(Map<String, dynamic> json) => FoodDataModel(
    categoryId: json["categoryId"],
    foodId: json["foodId"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    image: json["image"],
    tax: json["tax"]?.toDouble(),
    offPrice: json["offPrice"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "foodId": foodId,
    "name": name,
    "price": price,
    "description": description,
    "image": image,
    "tax": tax,
    "offPrice":offPrice
  };
}
