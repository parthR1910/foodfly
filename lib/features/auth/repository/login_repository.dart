import 'package:flutter/cupertino.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_const.dart';
import 'package:food_fly_delivery_partner/common/utils/data_types.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/local_db.dart';

class LoginRepository{

  static Future<String> loginWithEmailAndPass(String email,String password)async {
    final response  = await AuthService.authService.signInWithEmailAndPassword(email: email, password: password);
    if(response.user!=null){
      return 'Login SuccessFully';
    }
    return response.error!;
  }
}