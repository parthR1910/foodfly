import 'dart:async';
import 'package:hive/hive.dart';

import '../../model/user/user_model.dart';


class BoxService{

  late Box<UserModel> userModelBox;
  late Box<LatLng> latLngBox;

  BoxService._private();
  static BoxService boxService = BoxService._private();


  Future<void> addUserDetailToHive(dynamic userDetailDataKey,UserModel userModel)async{
    await userModelBox.put(userDetailDataKey,userModel);
  }

  Future<void> clearAllBoxes() async {
    await userModelBox.clear();
  }

}