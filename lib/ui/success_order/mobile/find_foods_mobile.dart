import '../../utils/common_device_config.dart';
import '../../utils/theme/app_assets.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_routes.dart';
import '../../utils/theme/app_string.dart';
import '../../utils/theme/app_text_style.dart';
import '../../utils/theme/theme.dart';
import '../../utils/widgets/common_button.dart';

class FindFoodsMobile extends ConsumerWidget {
  const FindFoodsMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return Scaffold(
      body: _bodyWidget(ref, context),
    );
  }

  Widget _bodyWidget(WidgetRef ref,BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Image.asset(AppAssets.burgerBoyPng),
            SizedBox(
              height: 30.h,
            ),
            Text(
              textAlign: TextAlign.center,
              ref.watch(appStringController).keyOuchHungry,
              style: AppTextStyle.w4
                  .copyWith(fontSize: 20.sp, color: AppColors.kBlack),
            ),
            Text(
              textAlign: TextAlign.center,
              ref.watch(appStringController).keyFindFoodSummary,
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
                ref.watch(appStringController).keyFindFoods,
                style: AppTextStyle.w5
                    .copyWith(fontSize: 14.sp, color: AppColors.kWhite),
              ),
            ),
          ],
        ),
      ));
}
