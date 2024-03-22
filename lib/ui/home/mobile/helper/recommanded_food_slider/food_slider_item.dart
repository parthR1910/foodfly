import 'dart:ffi';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import '../../../../../framework/model/food_data_model/food_data_model.dart';
import '../food_rating_star.dart';

class FoodSliderItem extends ConsumerWidget {
  final FoodDataModel foodData;
  const FoodSliderItem({
    required this.foodData,
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final random = Random();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.foodDetail, arguments: foodData);
      },
      child: Container(
        width: 200.w,
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
              tag: foodData.image??"",
              child: Banner(
                location: BannerLocation.topEnd,
                message: '₹ ${foodData.offPrice} OFF ',
                color: AppColors.kPrimary,
                child: Container(
                  color: Colors.blue.shade200,
                  height: 130.h,
                  width: 200.w,
                  child: CachedNetworkImage(
                    imageUrl: foodData.image!,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const FlutterLogo(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodData.name!,
                    style: AppTextStyle.w4.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text('Price : ',
                          style: AppTextStyle.w5.copyWith(fontSize: 12.sp)),
                      Text(' ₹ ${foodData.price! - foodData.offPrice!} ',
                          style: AppTextStyle.w5.copyWith(fontSize: 16.sp,color: AppColors.kPrimary))
                    ],
                  ),
                  SizedBox(height: 4.h),
                   const FoodRatingStar(ratingStar:4),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
