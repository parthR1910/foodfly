
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/register_controller.dart';
import 'package:food_fly_delivery_partner/features/auth/login/mobile/login.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          btnText: 'Sign Up Now',
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already Have An Account',
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF575757)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const Login()), (route) => false);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontWeight:FontWeight.w500,color: context.primaryColor, fontSize: 14.sp),
                ))
          ],
        )
      ],
    );
  }
}
