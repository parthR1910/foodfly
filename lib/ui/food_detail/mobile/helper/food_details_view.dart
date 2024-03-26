import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_fly/framework/controller/food_controller/food_controlller.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/model/user/user_model.dart';

import 'package:food_fly/framework/service/shared_pref_services.dart';
import 'package:food_fly/ui/home/mobile/helper/food_rating_star.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'food_detail/food_quantity_picker.dart';

class FoodDetailView extends ConsumerWidget {
  const FoodDetailView({super.key, required this.foodData});
  final FoodDataModel foodData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodWatch = ref.watch(foodController);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(foodData.name ?? "",
                  style: AppTextStyle.w6.copyWith(fontSize: 23.sp)),
              SizedBox(height: 10.h),
              RatingBar.builder(
                initialRating:
                    foodWatch.calculateAverageRating(foodData.ratings ?? []),
                minRating: 0,
                itemSize: 20,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                glowColor: AppColors.kPrimary.withOpacity(.5),
                glow: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star_rounded, color: AppColors.kPrimary),
                onRatingUpdate: (rating) {},
              ),
              // const FoodRatingStar(ratingStar: 4)
            ])
          ]),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text('Price : ',
                  style: AppTextStyle.w5.copyWith(fontSize: 18.sp)),
              foodData.offPrice! == 0
                  ? const SizedBox()
                  : Text(foodData.price.toString(),
                      style: AppTextStyle.w5.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.textGreyColor,
                        decoration: TextDecoration.lineThrough,
                      )),
              Text(' ₹ ${foodData.price! - foodData.offPrice!} ',
                  style: AppTextStyle.w5
                      .copyWith(fontSize: 20.sp, color: AppColors.kPrimary))
            ],
          ),
          Text(foodData.description ?? "",
              style: AppTextStyle.w4
                  .copyWith(fontSize: 12.sp, color: AppColors.kGrey)),
          SizedBox(height: 16.h),
          SharedPrefServices.services.getBool(isAdminKey)
              ? const SizedBox()
              : FoodQuantityPicker(
                  foodDataModel: foodData,
                ),
          SizedBox(height: 30.h),
          Text(
            'Reviews',
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.kPrimary),
          ),
          if (foodData.ratings != null)
            ...foodData.ratings!
                .map(
                  (e) => StreamBuilder<UserModel>(
                      stream: FirebaseFirestore.instance
                          .collection('User')
                          .doc(e.uid)
                          .snapshots()
                          .map((event) => UserModel.fromJson(event.data()!)),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const SizedBox();
                        }
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data!.profileImage!),
                              ),
                              title: Text(snapshot.data?.name ?? 'User'),
                              subtitle: Text(e.remarks),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: const Divider(
                                color: AppColors.kPrimary,
                                height: 0,
                              ),
                            )
                          ],
                        );
                      }),
                )
                .toList()
          else
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Center(child: Text('No reviews found')),
            ),
          SizedBox(
            height: 100.h,
          )
        ],
      ),
    );
  }
}
