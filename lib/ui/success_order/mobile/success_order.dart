import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';

import '../../utils/theme/theme.dart';

class SuccessOrder extends ConsumerWidget {
  const SuccessOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return Scaffold(
      body: _bodyWidget(ref, context),
    );
  }

  Widget _bodyWidget(WidgetRef ref, BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.h,
          ),
          Image.asset(AppAssets.deliveryBoyPng),
          SizedBox(
            height: 30.h,
          ),
          Text(
            textAlign: TextAlign.center,
            ref.watch(appStringController).keyYouHaveMadeOrder,
            style: AppTextStyle.w4
                .copyWith(fontSize: 20.sp, color: AppColors.kBlack),
          ),
          Text(
            textAlign: TextAlign.center,
            ref.watch(appStringController).keyOrderedFoodSummary,
            style: AppTextStyle.w3
                .copyWith(fontSize: 14.sp, color: AppColors.kBlack),
          ),
          SizedBox(
            height: 30.h,
          ),
          CommonButton(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false);
            },
            padding: EdgeInsets.symmetric(vertical: 12.w, ),
            child: Text(
              ref.watch(appStringController).keyOrderOtherFoods,
              style: AppTextStyle.w5
                  .copyWith(fontSize: 14.sp, color: AppColors.kWhite),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context,  AppRoutes.cancelOrder);
            },
            child: Container(
              height: 45.h,
              width: 200.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.kWhite,
                  border: Border.all(color: AppColors.kPrimary, width: 1)),
              child: Center(
                child: Text(
                  ref.watch(appStringController).keyViewMyOrder,
                  style: AppTextStyle.w5
                      .copyWith(fontSize: 14.sp, color: AppColors.kPrimary),
                ),
              ),
            ),
          )
        ],
      ));
}
