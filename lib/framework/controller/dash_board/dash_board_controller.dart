import 'package:food_fly/ui/cart/mobile/helper/cart.dart';
import 'package:food_fly/ui/home/mobile/home.dart';
import 'package:food_fly/ui/user_profile/mobile/user_profile.dart';
import 'package:food_fly/ui/cart/mobile/orders.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

final dashBoardStateProvider =
    StateNotifierProvider<DashBoardStateNotifier, int>(
        (ref) => DashBoardStateNotifier());

class DashBoardStateNotifier extends StateNotifier<int> {
  DashBoardStateNotifier() : super(0);

  List<Widget> screens = [
    const Home(),
    const Cart(),
    const Orders(),
    const UserProfile(),
  ];

  List<Widget> adminScreens = [
    const Home(),
    const UserProfile(),
  ];

  void navigateTo(int index) {
    state = index;
  }

  bool isExitApp = false;

  updateIsExitApp(bool value) {
    isExitApp = value;
  }
}
