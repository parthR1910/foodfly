import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import '../../../../../framework/model/food_item.dart';
import '../../../../utils/theme/theme.dart';

class FoodSummery extends StatelessWidget {
  const FoodSummery(this.foodItem, {super.key});
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Text(
      foodItem.summary,
      style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kGrey),
    );
  }
}
