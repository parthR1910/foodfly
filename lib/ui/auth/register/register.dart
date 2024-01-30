import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/theme/theme.dart';
import 'mobile/register_mobile.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) => ScreenTypeLayout.builder(
        mobile: (BuildContext context) => const RegisterMobile(),
      );
}
