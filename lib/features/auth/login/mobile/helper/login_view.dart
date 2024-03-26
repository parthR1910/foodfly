import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_assets.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:lottie/lottie.dart';

import 'social_button.dart';
import 'login_form.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300.h,
              decoration: BoxDecoration(
              color: context.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r),bottomRight: Radius.circular(40.r))
              ),
              child: Lottie.asset(AppAssets.deliveryBoyLottie,height: 300.h)),
         Padding(

           padding: EdgeInsets.only(top: 62.h, left: 24.w, right: 24.w),

           child: Column(
             children: [
               LoginForm(),
               SizedBox(height: 10.h),
               const Text(
                 'Or Continue With',
                 style: TextStyle(color: Colors.grey),
               ),
               const SocialAuthButtons()
             ],
           ),
         )
        ],
      ),
    );
  }
}
