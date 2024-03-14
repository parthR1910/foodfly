import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'social_button.dart';
import 'login_form.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 62.h, left: 24.w, right: 24.w),
      child: Column(
        children: [
           LoginForm(),
          SizedBox(height: 10.h),
          // Text(
          //   ref.watch(appStringController).keyORContinueWith,
          //   style: AppTextStyle.w3.copyWith(color: AppColors.kGrey),
          // ),
          // const SocialAuthButtons()
        ],
      ),
    );
  }
}
