
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/features/auth/register/mobile/helper/register_button.dart';
import 'package:food_fly_delivery_partner/features/auth/register/mobile/helper/register_form.dart';

class RegisterView extends StatelessWidget {

  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 74.h, left: 24.w, right: 24.w),
      child: const Column(
        children: [RegisterForm(), RegisterButton()],
      ),
    );
  }
}
