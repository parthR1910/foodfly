import 'package:food_fly/framework/controller/dash_board/dash_board_controller.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';

import '../../utils/theme/theme.dart';
import 'helper/my_bottom_navigationbar.dart';

class DashBoard extends ConsumerWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return Scaffold(
      body: ref
          .watch(dashBoardStateProvider.notifier)
          .screens[ref.watch(dashBoardStateProvider)],
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
