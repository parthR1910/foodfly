import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_const.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/services/local_db.dart';
import 'package:food_fly_delivery_partner/features/profile/repository/profile_repository.dart';

final profileControllerProvider = ChangeNotifierProvider<ProfileController>((ref) {
  return ProfileController();
});


class ProfileController extends ChangeNotifier{

 //  Future<UserModel?> getProfileDetails(BuildContext context)async{
 // return await context.read<ProfileRepository>().getProfileDetails(context);
 //  }
  showLogoutBottomSheet(BuildContext context){
    showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      context: context,
      transitionDuration: 200.milliseconds,
      transitionBuilder:
          (context, animation, secondaryAnimation, child) =>
          ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(onPressed: (){
              context.pop();
            }, child:  const Text('Cancel',style: TextStyle(color: Colors.black),)),
            ElevatedButton(onPressed: () async {
              await LocalDb.setInt(userIdKey, -1);
              context.pushAndRemoveUntilNamed(AppRoutes.login);
            }, child:  const Text('Ok',style: TextStyle(color: Colors.black),)),
          ],

title: Text('Are Sure to Logut',style: TextStyle(fontSize: 15.sp,)));
            },
    );
  }
}

