import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/ui/home_address/home_address.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

final profileController = ChangeNotifierProvider((ref) =>ProfileController() );

class ProfileController extends ChangeNotifier{

  profileAccountNavigation(int index,BuildContext context){
    switch(index){
      case 0:
        Navigator.pushNamed(context, AppRoutes.editProfile);
        break;
      case 1:
        // Navigator.pushNamed(context, AppRoutes.editProfile);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomeAddress()));
        break;
      case 2:
        // Navigator.pushNamed(context, AppRoutes.editProfile);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Scaffold()));
        break;
      case 3:
        // Navigator.pushNamed(context, AppRoutes.editProfile);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Scaffold()));
        break;
      case 4:
        Future.delayed(const Duration(milliseconds: 700),()async{
          launchUrl(Uri(
            scheme: 'mailto',
            path: "parthrathod313@gmail.com",
          ));});
        break;
    }
  }
  adminProfileAccountNavigation(int index,BuildContext context){
    switch(index){
      case 0:
        Navigator.pushNamed(context, AppRoutes.editProfile);
        break;
      case 1:
      // Navigator.pushNamed(context, AppRoutes.editProfile);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Scaffold()));
        break;
      case 2:
      // Navigator.pushNamed(context, AppRoutes.editProfile);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Scaffold()));
        break;
      case 3:
      // Navigator.pushNamed(context, AppRoutes.editProfile);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Scaffold()));
        break;
      case 4:
      // Navigator.pushNamed(context, AppRoutes.editProfile);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Scaffold()));
        break;
    }
  }
}