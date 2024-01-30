import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';

import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/app_text_style.dart';
import '../../../../utils/theme/theme.dart';

class FoodIngredients extends ConsumerWidget {
  const FoodIngredients(this.foodItem, {super.key});
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appString.keyIngredients,
          style: AppTextStyle.w4
              .copyWith(fontSize: 14.sp, color: AppColors.kBlack),
        ),
        SizedBox(height: 4.h),
        Text(
          foodItem.ingredients,
          style:
              AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kGrey),
        ),
      ],
    );
  }
}
