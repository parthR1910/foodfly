import 'package:food_fly/framework/data/dummy_data.dart';

import 'package:food_fly/ui/utils/theme/theme.dart';
import 'food_slider_item.dart';

class FoodItemSlider extends StatelessWidget {
  const FoodItemSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 210.h,
        width: double.infinity,
        child: ListView.builder(
          itemCount: availableFoods.length,
          padding: EdgeInsets.only(bottom: 10.h, left: 18.w),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              FoodSliderItem(foodItem: availableFoods[index]),
        ));
  }
}
