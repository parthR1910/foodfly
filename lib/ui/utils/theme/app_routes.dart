import 'package:flutter/material.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/add_food/add_food.dart';
import 'package:food_fly/ui/auth/login/mobile/login.dart';
import 'package:food_fly/ui/splash/mobile/splash.dart';
import '../../auth/register/mobile/register.dart';
import '../../cancel_order/mobile/cancel_order.dart';
import '../../cart/mobile/cart.dart';
import '../../dashboard/mobile/dashboard.dart';
import '../../food_detail/mobile/food_detail.dart';
import '../../payment/mobile/payment.dart';
import '../../success_order/mobile/find_foods.dart';
import '../../success_order/mobile/success_order.dart';
import '../../user_profile/mobile/user_profile.dart';
import '../../welcome/mobile/welcome.dart';

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
  static const String addFood = '/addFood';


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
                FoodDetail(foodData: settings.arguments as FoodDataModel,));
      case payment:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        final FoodDataModel foodData = arguments['foodData'];
        final int quantity = arguments['quantity'];
        return MaterialPageRoute(builder: (context)=>  Payment(foodData: foodData,quantity: quantity,));
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
      case addFood:
        return MaterialPageRoute(builder: (context)=> const AddFood());
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
