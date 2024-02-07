import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';

import 'package:food_fly/framework/service/shared_pref_services.dart';
import 'package:food_fly/ui/home/mobile/helper/food_rating_star.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(foodData.name ?? "",
                  style: AppTextStyle.w6.copyWith(fontSize: 23.sp)),
              const FoodRatingStar(ratingStar: 4)
            ])
          ]),
          SizedBox(height: 14.h),
          Row(
            children: [
              Text('Price : ',
                  style: AppTextStyle.w5.copyWith(fontSize: 18.sp)),
              foodData.offPrice! == 0? const SizedBox(): Text(foodData.price.toString(),
                  style: AppTextStyle.w5.copyWith(fontSize: 14.sp,color: AppColors.textGreyColor,decoration: TextDecoration.lineThrough, )),
              Text(' ₹ ${foodData.price! - foodData.offPrice!} ',
                  style: AppTextStyle.w5.copyWith(fontSize: 20.sp,color: AppColors.kPrimary))
            ],
          ),
          Text(foodData.description ?? "",
              style: AppTextStyle.w4
                  .copyWith(fontSize: 12.sp, color: AppColors.kGrey)),
          SizedBox(height: 16.h),
          SharedPrefServices.services.getBool(isAdminKey)?const SizedBox(): FoodQuantityPicker(foodDataModel: foodData,),
          SizedBox(height: 100.h,)
        ],
      ),
    );
  }
}
