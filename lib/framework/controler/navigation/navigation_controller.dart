import 'package:food_fly/ui/home/mobile/home.dart';
import 'package:food_fly/ui/user_profile/mobile/user_profile.dart';
import 'package:food_fly/ui/cart/mobile/cart.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

final navigationStateProvider =
    StateNotifierProvider<NavigationStateNotifier, int>(
        (ref) => NavigationStateNotifier());

class NavigationStateNotifier extends StateNotifier<int> {
  NavigationStateNotifier() : super(0);

  List<Widget> screens = [
    const Home(),
    const Cart(),
    const UserProfile(),
  ];

  void navigateTo(int index) {
    state = index;
  }
}
