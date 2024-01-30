import 'package:food_fly/framework/controler/navigation/navigation_controller.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';

import '../../utils/theme/theme.dart';
import 'helper/my_bottom_navigationbar.dart';

class DashBoardMobile extends ConsumerWidget {
  const DashBoardMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return Scaffold(
      body: ref
          .watch(navigationStateProvider.notifier)
          .screens[ref.watch(navigationStateProvider)],
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
