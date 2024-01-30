import 'package:food_fly/ui/utils/constant/enum.dart';

class FoodItem {
  final String name;
  final String imgUrl;
  final String summary;
  final String ingredients;
  final int star;
  final String price;
  final FoodCategoryType category;

  FoodItem(
      {required this.name,
      required this.summary,
      required this.ingredients,
      required this.price,
      required this.imgUrl,
      required this.star,
      required this.category});
}
