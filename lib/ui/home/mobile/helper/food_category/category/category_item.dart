import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/home/mobile/helper/food_rating_star.dart';

class CategoryFoodItem extends StatelessWidget {
  final FoodDataModel foodDate;
  const CategoryFoodItem({super.key,
    required this.foodDate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.foodDetail, arguments: foodDate);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              height: 60.h,
              width: 70.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10.r)
              ),
              child:  CachedNetworkImage(
                imageUrl: foodDate.image!,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const FlutterLogo(),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // foodItem.name,
                  foodDate.name??"",
                  style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
                ),
                Text(
                  'INR ₹ ${foodDate.price}',
                  style: AppTextStyle.w4
                      .copyWith(fontSize: 13.sp, color: AppColors.kGrey),
                ),
              ],
            ),
            const Spacer(),
            const FoodRatingStar(ratingStar: 3),
          ],
        ),
      ),
    );
  }
}
