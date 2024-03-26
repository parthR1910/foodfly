
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/features/auth/register/mobile/helper/img_input.dart';
import 'package:food_fly_delivery_partner/features/auth/register/mobile/helper/register_input_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [ImgInput(), RegisterInputField()],
    );
  }
}
