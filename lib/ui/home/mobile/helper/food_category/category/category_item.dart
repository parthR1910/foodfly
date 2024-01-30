import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../../../utils/theme/app_routes.dart';
import '../../food_rating_star.dart';

class CategoryFoodItem extends StatelessWidget {
  const CategoryFoodItem({super.key, required this.foodItem});
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.foodDetail, arguments: foodItem);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: const FlutterLogo(),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem.name,
                  style: AppTextStyle.w4.copyWith(fontSize: 16.sp),
                ),
                Text(
                  'IDR \$ ${foodItem.price}.00',
                  style: AppTextStyle.w4
                      .copyWith(fontSize: 13.sp, color: AppColors.kGrey),
                ),
              ],
            ),
            const Spacer(),
            FoodRatingStar(ratingStar: foodItem.star),
          ],
        ),
      ),
    );
  }
}
