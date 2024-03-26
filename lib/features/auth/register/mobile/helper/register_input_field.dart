import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/common_form_field.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/register_controller.dart';

import '../../../../../common/utils/helper/validator.dart';

class RegisterInputField extends ConsumerWidget {
  const RegisterInputField( {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerWatch = ref.watch(registerController);
    return Form(
      key: registerWatch.registerKey,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          'Full Name',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.newline,
          controller: registerWatch.nameController,
          hintText: 'Enter Your Full Name',
          validator: requiredFieldValidator,
          onSaved: (value) {},
        ),
        SizedBox(height: 16.h),
        Text(
          'Email Address',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: registerWatch.emailController,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.emailAddress,
          validator: emailValidator,
          hintText: 'Enter Your Email Address',
          onSaved: (value) {},
        ),
        SizedBox(height: 16.h),
        Text(
          'Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: registerWatch.passwordController,
          textInputAction: TextInputAction.done,
          obscureText: registerWatch.isPassNotShow,
          hintText: 'Enter your Password',
          validator: passValidator,
          suffixIcon: IconButton(onPressed: (){
            registerWatch.updatesIsPassNotShow();
          },icon: Icon(registerWatch.isPassNotShow?Icons.remove_red_eye:Icons.clear,color: context.primaryColor,),),
          onSaved: (value) {},
        ),
        const SizedBox(height: 24)
      ],
    ));
  }
}
