import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/tap_to_remove_key_board.dart';
import 'package:food_fly_delivery_partner/features/auth/ui/widgets/login_form.dart';
import 'package:food_fly_delivery_partner/features/auth/ui/widgets/login_header.dart';
import 'package:food_fly_delivery_partner/features/auth/ui/widgets/social_login.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return  const TapToRemoveKeyBoardWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
            LoginHeader(),
              LoginForm(),
              SocialLogin(),
            ],
          ),
        )
      ),
    );
  }
}
