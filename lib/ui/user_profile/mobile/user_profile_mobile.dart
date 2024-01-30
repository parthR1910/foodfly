import 'package:food_fly/framework/controler/authentication/login_controller.dart';
import 'package:food_fly/ui/user_profile/mobile/helper/user_account_item.dart';
import 'package:food_fly/ui/user_profile/mobile/helper/user_detail.dart';
import 'package:food_fly/ui/user_profile/mobile/helper/user_food_market_details.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';

class UserProfileMobile extends ConsumerWidget {
  const UserProfileMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
         PopupMenuButton(itemBuilder: (context) {
           return  [
             PopupMenuItem(child: InkWell(
               onTap: (){
                ref.watch(loginController).signOut();
                 // ignore: use_build_context_synchronously
                 Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signInRoute, (route) => false);
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("LogOut", style:AppTextStyle.w6.copyWith(fontSize: 14.sp,color: AppColors.kBlack),),
                   const Icon(Icons.logout,color: AppColors.kPrimary,)
                 ],
               ),
             )),

           ];
         },)
        ],
      ),
      body: _bodyWidget(ref),
    );
  }

  Widget _bodyWidget(WidgetRef ref) => SafeArea(
    child: Column(
          children: [
            SizedBox(
              height: 26.h,
            ),
            const UserDetails(),
            Expanded(
              child: DefaultTabController(
                length: 2, // Set the number of tabs
                child: Padding(
                  padding: EdgeInsets.only(top: 66.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 300.w,
                            child: TabBar(
                              indicatorColor: AppColors.kBlack,
                              labelColor: AppColors.kBlack,
                              unselectedLabelColor: AppColors.kGrey,
                              tabs: [
                                Tab(
                                    text: ref
                                        .watch(appStringController)
                                        .keyAccount), // Tab 1 label
                                Tab(
                                    text: ref
                                        .watch(appStringController)
                                        .keyFoodMarket), // Tab 2 label
                              ],
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            UserAccountItem(),
                            UserFoodMarketDetails(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
  );
}
