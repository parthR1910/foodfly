import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/food_detail/mobile/food_detail_mobile.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({super.key, required this.foodItem});
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => FoodDetailMobile(foodItem: foodItem),
    );
  }
}
