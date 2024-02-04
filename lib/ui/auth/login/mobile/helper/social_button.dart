import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/controler/authentication/login_controller.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';

import '../../../../utils/theme/theme.dart';
import '../../../register/mobile/register.dart';

class SocialAuthButtons extends ConsumerWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    final loginWatch = ref.watch(loginController);
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        socialLogin(appString, loginWatch, context),
        SizedBox(
          height: 24.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appString.keyCreateAnAccount,
              style: AppTextStyle.w4
                  .copyWith(fontSize: 14.sp, color: const Color(0xFF575757)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Register(),
                    ));
              },
              child: Text(
                appString.keySignUp,
                style: AppTextStyle.w6
                    .copyWith(fontSize: 14.sp, color: AppColors.kPrimary),
              ),
            )
          ],
        )
      ],
    );
  }

  Row socialLogin(AppString appString, LoginController loginWatch,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonButton(
          onTap: () {
            loginWatch.googleLogin(context);
          },
          iconButton: true,
          radius: 50.r,
          backgroundColor: AppColors.kLighRed,
          icon: SvgPicture.asset(
            AppAssets.googleSvg,
            height: 24.h,
            width: 24.w,
          ),
          child: Text(
            appString.keyGoogle,
            style:
                AppTextStyle.w4.copyWith(fontSize: 12.sp, color: Colors.black),
          ),
        ),
        SizedBox(width: 10.w),
        CommonButton(
          onTap: () {},
          radius: 50.r,
          iconButton: true,
          backgroundColor: AppColors.kLighRed,
          icon: SvgPicture.asset(
            AppAssets.facebookSvg,
            height: 24.h,
            width: 24.w,
          ),
          child: Text(
            appString.keyFacebook,
            style:
                AppTextStyle.w4.copyWith(fontSize: 12.sp, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
