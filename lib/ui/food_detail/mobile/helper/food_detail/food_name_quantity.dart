import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/home/mobile/helper/food_rating_star.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import '../../../../utils/theme/theme.dart';
import 'food_quantity_picker.dart';

class FoodNameAndQuantity extends StatelessWidget {
  const FoodNameAndQuantity(
    this.foodItem, {
    super.key,
  });
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              foodItem.name,
              style: AppTextStyle.w4.copyWith(fontSize: 16.sp),
            ),
            FoodRatingStar(ratingStar: foodItem.star)
          ],
        ),
        const FoodQuantityPicker()
      ],
    );
  }
}
