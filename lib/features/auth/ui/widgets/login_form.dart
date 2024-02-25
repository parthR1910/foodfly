import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_assets.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/features/auth/controller/login_controller.dart';

import '../../../../common/utils/helper/validator.dart';
import '../../../../common/utils/widgets/text_input.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      child: Form(
        key: loginWatch.loginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            MyTextInput(
              filled: true,
              hintText: 'Email Address',
              textInputAction: TextInputAction.next,
              controller: loginWatch.emailController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
              prefixIcon: const IconButton(
                onPressed: null,
                icon: Icon(Icons.email_rounded),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              customBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: Colors.white)),
              filledColor: Colors.grey.shade200,
            ),
            SizedBox(height: 20.h),
            MyTextInput(
              filled: true,
              hintText: 'Password',
              validator: passValidator,
              controller: loginWatch.passController,
              autoValidateMode: AutovalidateMode.onUserInteraction,

              prefixIcon: const IconButton(onPressed: null, icon: Icon(Icons.password)),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              customBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: Colors.white)),
              filledColor: Colors.grey.shade200,
            ),
            SizedBox(height: 15.h),
            TextButton(onPressed: (){}, child: Text('Forget password?',style: TextStyle(color: Colors.black,fontSize: 13.sp),)),
            SizedBox(height: 15.h),
        CommonButton(
          isLoading: loginWatch.loading,
          btnText: 'Login',onTap: (){
          loginWatch.login(context);
        },backgroundColor: Colors.black,fontWeight: FontWeight.w700,),
            SizedBox(height: 30.h),

          ],
        ),
      ),
    );
  }
}
