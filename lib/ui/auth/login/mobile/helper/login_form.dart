import 'package:food_fly/framework/controller/authentication/login_controller.dart';
import 'package:food_fly/ui/utils/form_validator.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';

import '../../../../utils/widgets/common_form_field.dart';

class LoginForm extends ConsumerWidget {
  final GlobalKey<FormState> loginKey = GlobalKey();
   LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    final loginWatch = ref.watch(loginController);
    return Form(
        key: loginKey,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          appString.keyEmailAddress,
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: loginWatch.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.newline,
          hintText: appString.keyTypeYourEmailAddress,
          validator: emailValidator,
          onSaved: (value) {},
        ),
        SizedBox(height: 16.h),
        Text(
          appString.keyPassword,
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: loginWatch.passwordController,
          textInputAction: TextInputAction.done,
          obscureText: loginWatch.isPassNotShow,
          hintText: appString.keyTypeYourPassword,
          validator: requiredFieldValidator,
          suffixIcon: IconButton(onPressed: (){
            loginWatch.updatesIsPassNotShow();
          },icon: Icon(loginWatch.isPassNotShow?Icons.remove_red_eye:Icons.clear,color: AppColors.kPrimary,),),
          onSaved: (value) {},
        ),
        SizedBox(height: 24.h),
        CommonButton(
          onTap: () async{
            if(loginKey.currentState?.validate() ?? false){
              FocusScope.of(context).unfocus();
              await loginWatch.signInWithEmailAndPassword(context);
              loginWatch.clearForm();
            }
          },
          padding:  EdgeInsets.symmetric(vertical: 12.h,),
          child: Text(
            appString.keySignIn,
            style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
          ),
        ),
        Align(
          child: TextButton(
            onPressed: () {},
            child: Text(
              appString.keyForgetPassword,
              style: AppTextStyle.w4
                  .copyWith(color: AppColors.kPrimary, fontSize: 12),
            ),
          ),
        ),
      ],
    ));
  }
}
