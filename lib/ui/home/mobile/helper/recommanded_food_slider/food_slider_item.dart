import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import '../food_rating_star.dart';

class FoodSliderItem extends ConsumerWidget {
  const FoodSliderItem({
    required this.foodItem,
    super.key,
  });
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.foodDetail, arguments: foodItem);
      },
      child: Container(
        width: 200.w,
        height: 210.h,
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(right: 24.w),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100, blurRadius: 5, spreadRadius: 5)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: foodItem.name,
              child: Banner(
                location: BannerLocation.topEnd,
                message: 'Sale 50% off ',
                color: AppColors.kPrimary,
                child: Container(
                  color: Colors.blue,
                  height: 140.h,
                  width: 200.w,
                  child: const FlutterLogo(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodItem.name,
                    style: AppTextStyle.w4.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 6.h),
                  FoodRatingStar(ratingStar: foodItem.star)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
