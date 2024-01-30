import 'package:food_fly/framework/controler/authentication/register_controller.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import '../../../../utils/form_validator.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/app_text_style.dart';
import '../../../../utils/theme/theme.dart';
import '../../../../utils/widgets/common_form_field.dart';

class RegisterInputField extends ConsumerWidget {
  const RegisterInputField( {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    final registerWatch = ref.watch(registerController);
    return Form(
      key: registerWatch.registerKey,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          appString.keyFullName,
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          textInputAction: TextInputAction.newline,
          controller: registerWatch.nameController,
          hintText: appString.keyTypeYourFullName,
          onSaved: (value) {},
        ),
        SizedBox(height: 16.h),
        Text(
          appString.keyEmailAddress,
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          controller: registerWatch.emailController,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.emailAddress,
          validator: emailValidator,
          hintText: appString.keyTypeYourEmailAddress,
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
          controller: registerWatch.passwordController,
          textInputAction: TextInputAction.done,
          obscureText: registerWatch.isPassNotShow,
          hintText: appString.keyTypeYourPassword,
          validator: passValidator,
          suffixIcon: IconButton(onPressed: (){
            registerWatch.updatesIsPassNotShow();
          },icon: Icon(registerWatch.isPassNotShow?Icons.remove_red_eye:Icons.clear,color: AppColors.kPrimary,),),
          onSaved: (value) {},
        ),
        const SizedBox(height: 24)
      ],
    ));
  }
}
