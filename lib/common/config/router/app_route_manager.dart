import 'package:flutter/material.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/comp/compatibility_screen.dart';
import 'package:food_fly_delivery_partner/features/auth/address/mobile/address.dart';
import 'package:food_fly_delivery_partner/features/auth/login/mobile/login.dart';
import 'package:food_fly_delivery_partner/features/auth/register/mobile/register.dart';
import 'package:food_fly_delivery_partner/features/dashboard/ui/screens/dashboard.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/screens/bank_details.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/screens/notifications_list_screen.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/screens/personal_detail.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/screens/profile.dart';
import '../../../features/splash/splash.dart';
import 'app_routes.dart';
import 'package:page_transition/page_transition.dart';

class AppRouteManager {
  static Route onGenerateRoute(RouteSettings settings) {
    UserModel? userModel;
    if (settings.name == AppRoutes.personalDetails ||
        settings.name == AppRoutes.bankDetails) {
      userModel = settings.arguments as UserModel?;
    }
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => const Splash());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const Login());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (context) => const Register());
      case AppRoutes.registerDetail:
        return MaterialPageRoute(builder: (context) => const Address());
      case AppRoutes.dashboard:
        return PageTransition(
            child: const Dashboard(), type: PageTransitionType.fade);
      case AppRoutes.notifications:
        return PageTransition(
            child: const NotificationListScreen(),
            type: PageTransitionType.rightToLeftWithFade);
      case AppRoutes.personalDetails:
        return PageTransition(
            child: PersonalDetail(userModel: userModel!),
            type: PageTransitionType.rightToLeftWithFade);
      case AppRoutes.bankDetails:
        return PageTransition(
            child: BankDetails(userModel: userModel!),
            type: PageTransitionType.rightToLeftWithFade);
      case AppRoutes.profile:
        return PageTransition(
            child: const Profile(),
            type: PageTransitionType.rightToLeftWithFade);
      default:
        return MaterialPageRoute(
            builder: (context) => const Material(
                child: Center(child: Text('Something Went Wrong'))));
    }
  }
}
