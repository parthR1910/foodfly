import 'package:flutter_svg/svg.dart';
import 'package:food_fly/ui/payment/mobile/helper/payment_order_detail.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import '../../utils/theme/app_assets.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_string.dart';
import '../../utils/theme/app_text_style.dart';

class PaymentMobile extends ConsumerStatefulWidget {
  const PaymentMobile({super.key});

  @override
  ConsumerState<PaymentMobile> createState() => _PaymentMobileState();
}

class _PaymentMobileState extends ConsumerState<PaymentMobile> {
  @override
  Widget build(BuildContext context) {
    mobileDeviceConfig(context);
    return Scaffold(
      appBar: appBar,
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 48.h,
          ),
          const PaymentOrderDetail(),
          SizedBox(
            height: 64.h,
          ),
          CommonButton(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.successOrder);
            },
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              ref.watch(appStringController).keyCheckoutNow,
              style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  get appBar => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            AppAssets.arrowBackSvg,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ref.watch(appStringController).keyPayment,
                style: AppTextStyle.w5
                    .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
            Text(ref.watch(appStringController).keyYouDeserveBetterMeal,
                style: AppTextStyle.w3
                    .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
          ],
        ),
      );
}
