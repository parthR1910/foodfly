import '../utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/home_mobile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const HomeMobile();
      },
    );
  }
}
