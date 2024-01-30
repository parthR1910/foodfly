import 'package:food_fly/ui/auth/register/mobile/helper/register_button.dart';
import 'package:food_fly/ui/auth/register/mobile/helper/register_form.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

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
