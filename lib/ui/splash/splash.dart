import '../utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/splash_mobile.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const SplashMobile();
      },
    );
  }
}
