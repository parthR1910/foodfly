import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import '../../../home/mobile/helper/food_rating_star.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';
import 'food_detail/food_quantity_picker.dart';

class FoodDetailView extends StatelessWidget {
  const FoodDetailView({super.key, required this.foodData});

  final FoodDataModel foodData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodData.name??"",
                style: AppTextStyle.w4.copyWith(fontSize: 16.sp),
              ),
              const FoodRatingStar(ratingStar: 4)
            ],
          ),
          const FoodQuantityPicker()
        ],
      ),
          SizedBox(height: 14.h),
        Text(
          foodData.description??"",
          style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kGrey),
        ),
          SizedBox(height: 16.h),
          // FoodIngredients(foodItem),
        ],
      ),
    );
  }
}
