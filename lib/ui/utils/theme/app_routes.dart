import 'package:flutter/material.dart';
import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/auth/login/login.dart';
import 'package:food_fly/ui/cancel_order/cancel_order.dart';
import 'package:food_fly/ui/cart/cart.dart';
import 'package:food_fly/ui/dashboard/dashboard.dart';
import 'package:food_fly/ui/splash/splash.dart';
import 'package:food_fly/ui/success_order/find_foods.dart';
import 'package:food_fly/ui/success_order/success_order.dart';
import 'package:food_fly/ui/welcome/welcome.dart';
import 'package:food_fly/ui/auth/register/register.dart';
import '../../food_detail/food_detail.dart';
import '../../payment/payment.dart';
import '../../user_profile/user_profile.dart';

class AppRoutes {
  static const String splashRoute = '/splash';
  static const String signInRoute = '/signIn';
  static const String registerInRoute = '/register';
  static const String welcomeRoute = '/welcome';
  static const String dashBoard = '/dashboard';
  static const String foodDetail = '/foodDetail';
  static const String payment = '/payment';
  static const String cart = '/cart';
  static const String userprofile = '/userprofile';
  static const String cancelOrder = '/cancelOrder';
  static const String successOrder = '/successOrder';
  static const String findFoods = '/findFoods';


  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (context) => const Splash());
      case signInRoute:
        return MaterialPageRoute(builder: (context) => const Login());
      case registerInRoute:
        return MaterialPageRoute(builder: (context) => const Register());
      case welcomeRoute:
        return MaterialPageRoute(builder: (context) => const Welcome());
      case dashBoard:
        return MaterialPageRoute(builder: (context) => const DashBoard());
      case foodDetail:
        return MaterialPageRoute(
            builder: (context) =>
                FoodDetail(foodItem: settings.arguments as FoodItem));
      case payment:
        return MaterialPageRoute(builder: (context)=> const Payment());
      case cart:
        return MaterialPageRoute(builder: (context)=> const Cart());
      case userprofile:
        return MaterialPageRoute(builder: (context)=> const UserProfile());
      case cancelOrder:
        return MaterialPageRoute(builder: (context)=> const CancelOrder());
      case successOrder:
        return MaterialPageRoute(builder: (context)=> const SuccessOrder());
      case findFoods:
        return MaterialPageRoute(builder: (context)=> const FindFoods());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          ),
        );
    }
  }
}
