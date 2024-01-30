import 'package:responsive_builder/responsive_builder.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'mobile/login_mobile.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) => ScreenTypeLayout.builder(
        mobile: (BuildContext context) => const LoginMobile(),
      );
}
