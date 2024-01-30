import '../utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/welcome_mobile.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) => ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const WelcomeMobile());
}
