import 'package:flutter_svg/svg.dart';

import '../../utils/common_device_config.dart';
import '../../utils/theme/app_assets.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_routes.dart';
import '../../utils/theme/app_string.dart';
import '../../utils/theme/app_text_style.dart';
import '../../utils/theme/theme.dart';
import '../../utils/widgets/common_button.dart';
import 'helper/customer_order_detail_view.dart';

class CustomerOderDetail extends ConsumerStatefulWidget {
  const CustomerOderDetail({super.key});

  @override
  ConsumerState<CustomerOderDetail> createState() => _CancelOrderMobileState();
}

class _CancelOrderMobileState extends ConsumerState<CustomerOderDetail> {

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
        vertical: 10.h
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 48.h,
          ),
          const CustomerOrderDetailView(),
          SizedBox(
            height: 40.h,
          ),
          CommonButton(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.findFoods);
            },
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              ref.watch(appStringController).keyCancelMyOrder,
              style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
            ),
          )
        ],
      ),
    );
  }

  get appBar => AppBar(
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false);
      },
      icon: SvgPicture.asset(
        AppAssets.arrowBackSvg,
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your order",
            style: AppTextStyle.w5
                .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
        Text(ref.watch(appStringController).keyYouDeserveBetterMeal,
            style: AppTextStyle.w3
                .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
      ],
    ),
  );

}

