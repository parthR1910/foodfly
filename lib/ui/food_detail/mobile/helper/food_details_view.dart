import 'package:food_fly/framework/model/food_item.dart';
import '../../../utils/theme/theme.dart';
import 'food_detail/food_ingredients.dart';
import 'food_detail/food_name_quantity.dart';
import 'food_detail/food_summary.dart';

class FoodDetailView extends StatelessWidget {
  const FoodDetailView({super.key, required this.foodItem});

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FoodNameAndQuantity(foodItem),
        SizedBox(height: 14.h),
        FoodSummery(foodItem),
        SizedBox(height: 16.h),
        FoodIngredients(foodItem),
      ],
    );
  }
}
