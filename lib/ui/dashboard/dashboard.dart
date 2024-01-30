import '../utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/dashboard_mobile.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const DashBoardMobile();
      },
    );
  }
}
