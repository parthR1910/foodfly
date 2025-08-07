import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly/framework/controller/dash_board/dash_board_controller.dart';
import 'package:food_fly/framework/service/shared_pref_services.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/widgets/common_snackbar.dart';

import '../../utils/theme/theme.dart';
import 'helper/my_bottom_navigationbar.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {
  bool isExitApp = false;
  @override
  Widget build(
    BuildContext context,
  ) {
    mobileDeviceConfig(context);
    final dashBoardWatch = ref.watch(dashBoardStateProvider.notifier);
    return PopScope(
      canPop: isExitApp,
      onPopInvoked: (val) async {
        setState(() {
          isExitApp = true;
        });
        // commonToast("Press again to close app");

        await Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isExitApp = false;
          });
        });
      },
      child: Scaffold(
        body: SharedPrefServices.services.getBool(isAdminKey)
            ? dashBoardWatch.adminScreens[ref.watch(dashBoardStateProvider)]
            : dashBoardWatch.screens[ref.watch(dashBoardStateProvider)],
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
