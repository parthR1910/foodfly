import 'dart:convert';

FoodDataModel foodDataModelFromJson(String str) =>
    FoodDataModel.fromJson(json.decode(str));

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
  final int? deliveredCnt; // New field added
  final List<RatingDataModel>? ratings;

  FoodDataModel({
    this.categoryId,
    this.foodId,
    this.name,
    this.ratings,
    this.price,
    this.description,
    this.image,
    this.tax,
    this.offPrice,
    this.deliveredCnt, // Initialize the new field in the constructor
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
        deliveredCnt: json["deliveredCnt"], // Parse the new field from JSON
        ratings: (json['ratingsList'] != null)
            ? List<RatingDataModel>.from(json['ratingsList'].map(
                (model) => RatingDataModel.fromJson(model),
              ))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "foodId": foodId,
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "tax": tax,
        "offPrice": offPrice,
        "deliveredCnt": deliveredCnt, // Include the new field in JSON
        'ratingsList': ratings?.map((rating) => rating.toJson()).toList(),
      };
}

class RatingDataModel {
  final String uid;
  final num rating;
  final String orderId;
  final String remarks;

  RatingDataModel({
    required this.uid,
    required this.rating,
    required this.orderId,
    required this.remarks,
  });

  factory RatingDataModel.fromJson(Map<String, dynamic> json) {
    return RatingDataModel(
        uid: json['uid'] ?? '',
        rating: json['rating'] ?? 0.0,
        remarks: json['remarks'] ?? '',
        orderId: json['orderId'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'rating': rating,
      'remarks': remarks,
      'orderId': orderId
    };
  }
}
