import 'package:food_fly/ui/auth/register/mobile/helper/img_input.dart';
import 'package:food_fly/ui/auth/register/mobile/helper/register_input_field.dart';
import '../../../../utils/theme/theme.dart';

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
