import 'package:food_fly/framework/controller/dash_board/dash_board_controller.dart';
import 'package:food_fly/framework/service/shared_pref_services.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';

import '../../utils/theme/theme.dart';
import 'helper/my_bottom_navigationbar.dart';

class DashBoard extends ConsumerWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    final dashBoardWatch = ref.watch(dashBoardStateProvider.notifier);
    return Scaffold(
      body:SharedPrefServices.services.getBool(isAdminKey)?dashBoardWatch.adminScreens[ref.watch(dashBoardStateProvider)]:
      dashBoardWatch.screens[ref.watch(dashBoardStateProvider)],
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
