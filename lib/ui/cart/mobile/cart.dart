import 'package:food_fly/ui/cart/mobile/helper/cart_in_progress_item.dart';
import 'package:food_fly/ui/cart/mobile/helper/cart_past_order_item.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return Scaffold(
      appBar: appBar,
      body: _bodyWidget(ref),
    );
  }

  Widget _bodyWidget(WidgetRef ref) =>  SafeArea(
    child: DefaultTabController(
      length: 2, // Set the number of tabs
      child: Padding(
        padding:  EdgeInsets.only(top: 65.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 300.w,
                  child:  TabBar(
                    indicatorColor: AppColors.kBlack,
                    labelColor: AppColors.kBlack,
                    unselectedLabelColor: AppColors.kGrey,
                    tabs: [
                      Tab(text: ref.watch(appStringController).keyInProgress), // Tab 1 label
                      Tab(text: ref.watch(appStringController).keyPastOrders), // Tab 2 label
                    ],
                  ),
                ),
                const Spacer()
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  CartInProgressItem(),
                 CartPastOrderItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  AppBar get appBar =>
      AppBar(
        automaticallyImplyLeading: false,
        title: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ref
                    .watch(appStringController)
                    .keyYourOrders, style: AppTextStyle.w5.copyWith(
                    fontSize: 22.sp, color: AppColors.kBlack),),
                Text(ref
                    .watch(appStringController)
                    .keyWaitForTheBestMeal,style: AppTextStyle.w3.copyWith(
                    fontSize: 14.sp, color: AppColors.kGrey),),
              ],
            );
          },),
      );
}
