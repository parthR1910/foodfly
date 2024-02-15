import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_fly/framework/controller/dash_board/dash_board_controller.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import '../../../../framework/service/shared_pref_services.dart';
import '../../../utils/constant/app_const_list.dart';
import '../../../utils/theme/theme.dart';

class MyBottomNavigationBar extends ConsumerWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.kPrimary,
        currentIndex: ref.watch(dashBoardStateProvider),
        onTap: (index) {
          ref.read(dashBoardStateProvider.notifier).navigateTo(index);
        },
        items:SharedPrefServices.services.getBool(isAdminKey)?
        [
          BottomNavigationBarItem(
              icon: homeIcon, activeIcon: homeActiveIcon, label: 'Home'),
          BottomNavigationBarItem(
              icon: profileIcon,
              activeIcon: profileActiveIcon,
              label: 'Profile'),
        ]:
        [
          BottomNavigationBarItem(
              icon: homeIcon, activeIcon: homeActiveIcon, label: 'Home'),
          BottomNavigationBarItem(
              icon:
                  Badge(backgroundColor: AppColors.kPrimary, child: orderIcon),
              activeIcon: orderActiveIcon,
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: profileIcon,
              activeIcon: profileActiveIcon,
              label: 'Profile'),
        ]);
  }

  Widget get homeActiveIcon =>
      SvgPicture.asset(AppAssets.homeActiveIconSvg, width: 32.w, height: 32.h);

  Widget get homeIcon =>
      SvgPicture.asset(AppAssets.homeIconSvg, width: 32.w, height: 32.h);

  Widget get orderIcon =>
      SvgPicture.asset(AppAssets.orderIconSvg, width: 32.w, height: 32.h);

  Widget get orderActiveIcon =>
      SvgPicture.asset(AppAssets.orderActiveIconSvg, width: 32.w, height: 32.h);

  Widget get profileIcon =>
      SvgPicture.asset(AppAssets.profileIconSvg, width: 32.w, height: 32.h);

  Widget get profileActiveIcon =>
      SvgPicture.asset(AppAssets.profileActiveIconSvg,
          width: 32.w, height: 32.h);
}
