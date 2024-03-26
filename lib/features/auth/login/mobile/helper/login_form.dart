import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/helper/validator.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/common_form_field.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/text_input.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/login_controller.dart';

class LoginForm extends ConsumerWidget {
  final GlobalKey<FormState> loginKey = GlobalKey();
  LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    return Form(
        key: loginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
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
              controller: loginWatch.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.newline,
              hintText: 'Enter Your Email Address',
              validator: emailValidator,
              onSaved: (value) {},
            ),
            SizedBox(height: 16.h),
            Text(
              "Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: loginWatch.passwordController,
              textInputAction: TextInputAction.done,
              obscureText: loginWatch.isPassNotShow,
              hintText: 'Enter Your Password',
              validator: requiredFieldValidator,
              suffixIcon: IconButton(
                onPressed: () {
                  loginWatch.updatesIsPassNotShow();
                },
                icon: Icon(
                  loginWatch.isPassNotShow ? Icons.remove_red_eye : Icons.clear,
                  color: context.primaryColor,
                ),
              ),
              onSaved: (value) {},
            ),
            SizedBox(height: 24.h),
            CommonButton(
              isLoading: loginWatch.loading,
              onTap: () async {
                if (loginKey.currentState?.validate() ?? false) {
                  FocusScope.of(context).unfocus();
                  await loginWatch.signInWithEmailAndPassword(context);
                  loginWatch.clearForm();
                }
              },
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              btnText: 'Sign In',
            ),
            Align(
              child: TextButton(
                onPressed: () {
                  AwesomeDialog(
                          context: context,
                          customHeader: Icon(
                            Icons.email,
                            color: context.primaryColor,
                            size: 90.r,
                          ),
                          dialogType: DialogType.success,
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Forget Password\n',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.w800,
                                      color: context.primaryColor),
                                ),
                                Text(
                                  'Enter your email address. We send the email for reset your account password',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                MyTextInput(
                                  controller:
                                      loginWatch.forgetPassEmailController,
                                  label: 'Enter Your Email Address',
// padding: EdgeInsets.symmetric(horizontal:15.w,vertical: 10.h),
                                  customBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: context.primaryColor)),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          ),
                          btnOk: CommonButton(
                              onTap: () async {
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: loginWatch
                                              .forgetPassEmailController.text);
                                  context.pop();
                                  Fluttertoast.showToast(
                                      msg: 'Code has been sent to your mail');
                                } catch (e) {
                                  Fluttertoast.showToast(
                                      msg: 'Something went wrong');
                                }
                              },
                              btnText: 'Submit',
                              backgroundColor: context.primaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600))
                      .show();
                },
                child: Text(
                  'Forget Password',
                  style: TextStyle(color: context.primaryColor, fontSize: 12),
                ),
              ),
            ),
          ],
        ));
  }
}
