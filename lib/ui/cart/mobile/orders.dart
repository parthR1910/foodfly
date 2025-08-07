import 'package:food_fly/framework/controller/order_controller.dart';
import 'package:food_fly/ui/cart/mobile/helper/pending_orders.dart';
import 'package:food_fly/ui/cart/mobile/helper/completed_orders.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class Orders extends ConsumerWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return Scaffold(
      key: ref.read(orderControllerProvider).scaffoldKey,
      appBar: appBar,
      body: _bodyWidget(ref),
    );
  }

  Widget _bodyWidget(WidgetRef ref) => SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 370.w,
                    child: TabBar(
                      splashFactory: InkSplash.splashFactory,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      splashBorderRadius: BorderRadius.circular(8.r),
                      indicatorColor: Colors.black,
                      labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
                      tabs: [
                        Tab(
                          child: Text(
                            "Pending",
                            style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
                          ),
                        ),
                        // Tab(child: Text(
                        //   "Cart",style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
                        // ),),
                        Tab(
                          child: Text(
                            "Completed Orders",
                            style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    PendingOrders(),
                    CompletedOrders(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  AppBar get appBar => AppBar(
        automaticallyImplyLeading: false,
        title: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.watch(appStringController).keyYourOrders,
                  style: AppTextStyle.w5
                      .copyWith(fontSize: 22.sp, color: AppColors.kBlack),
                ),
                Text(
                  ref.watch(appStringController).keyWaitForTheBestMeal,
                  style: AppTextStyle.w3
                      .copyWith(fontSize: 14.sp, color: AppColors.kGrey),
                ),
              ],
            );
          },
        ),
      );
}
