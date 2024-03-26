import 'package:flutter_svg/svg.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_colors.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/login_controller.dart';
import '../../../register/mobile/register.dart';

class SocialAuthButtons extends ConsumerWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 24.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create An Account',
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF575757)),
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
                'Sign Up',
                style: TextStyle(fontWeight:FontWeight.w500,fontSize: 14.sp, color: context.primaryColor),
              ),
            )
          ],
        )
      ],
    );
  }

  // Row socialLogin( LoginController loginWatch,BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(width: 10.w),
  //       CommonButton(
  //         onTap: () {},
  //         radius: 50.r,
  //         iconButton: true,
  //         backgroundColor: AppColors.kLighRed,
  //         icon: SvgPicture.asset(
  //           AppAssets.facebookSvg,
  //           height: 24.h,
  //           width: 24.w,
  //         ),
  //         child: Text(
  //           appString.keyFacebook,
  //           style:
  //               AppTextStyle.w4.copyWith(fontSize: 12.sp, color: Colors.black),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
