import 'package:food_fly/framework/controler/authentication/register_controller.dart';
import 'package:food_fly/ui/auth/login/mobile/login_mobile.dart';

import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/app_string.dart';
import '../../../../utils/theme/app_text_style.dart';
import '../../../../utils/theme/theme.dart';
import '../../../../utils/widgets/common_button.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    final registerWatch = ref.watch(registerController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonButton(
          onTap: () async{
            if(registerWatch.registerKey.currentState!.validate()) {
              await registerWatch.signUpWithEmailAndPassword(context);
              registerWatch.clearForm();
            }
          },
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(
            appString.keySignUpNow,
            style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appString.keyIAlreadyHaveAnAccount,
              style: AppTextStyle.w4
                  .copyWith(fontSize: 14.sp, color: const Color(0xFF575757)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const LoginMobile()), (route) => false);
                },
                child: Text(
                  appString.keyLogIn,
                  style: AppTextStyle.w6
                      .copyWith(color: AppColors.kPrimary, fontSize: 14.sp),
                ))
          ],
        )
      ],
    );
  }
}
