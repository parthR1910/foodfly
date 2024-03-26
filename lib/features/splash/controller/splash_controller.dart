import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_const.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/local_db.dart';


final splashControllerProvider = ChangeNotifierProvider<SplashController>((ref) {
  return SplashController();
});


class SplashController extends ChangeNotifier{
  init(BuildContext context){
    Timer(const Duration(seconds: 2),() {
      if(AuthService.authService.auth.currentUser == null) {
        context.pushAndRemoveUntilNamed(AppRoutes.login);
      }else{
        context.pushAndRemoveUntilNamed(AppRoutes.dashboard);
      }
    },);
  }
}