import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_fly/framework/controller/dash_board/dash_board_controller.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/framework/service/hive_service/box_service.dart';
import 'package:food_fly/framework/service/shared_pref_services.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/helper.dart';

import '../../service/auth_service.dart';

final loginController  = ChangeNotifierProvider((ref) => LoginController(ref));

class LoginController extends ChangeNotifier{
  Ref ref;
  LoginController(this.ref);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool isPassNotShow = true;
  bool isGoogleLogin = false;


  updatesIsPassNotShow(){
    isPassNotShow = !isPassNotShow;
    notifyListeners();
  }


  Future signInWithEmailAndPassword(BuildContext context)async{
    loading = true;
    final authResponse = await AuthService.authService.signInWithEmailAndPassword(email:emailController.text, password: passwordController.text);
    if(authResponse.user != null){
      final uid = AuthService.authService.auth.currentUser!.uid;
      final userModel = await FireStoreService.fireStoreService.fireStore.collection("User").doc(uid).get().then((value) => UserModel.fromJson(value.data()!));
      BoxService.boxService.addUserDetailToHive(userModelDetailKey, userModel);
      loading=false;
      notifyListeners();
      if(authResponse.user!.email =="parth123@gmail.com"){
        SharedPrefServices.services.setBool(isAdminKey, true);
        if(context.mounted){
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false);
        }
      }else{
        SharedPrefServices.services.setBool(isAdminKey, false);
        if(context.mounted){
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false);
        }
      }
    }else{
      loading=false;
      if(context.mounted){
        showSnackBar(context: context, error: authResponse.error!);
      }
    }
    notifyListeners();
  }


  googleLogin(BuildContext context)async{
    loading = true;
    notifyListeners();
    final authResponse = await AuthService.authService.signInWithGoogle();
    if(authResponse.user != null){
      isGoogleLogin = true;
      if(context.mounted){
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false);
      }
      loading=false;
    }else{
      loading=false;
      if(context.mounted){
        showSnackBar(context: context, error: authResponse.error!);
      }
    }
    notifyListeners();
  }
  clearForm(){
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }


  Future<void> signOut(BuildContext context)async{
    if(isGoogleLogin){
      isGoogleLogin = false;
      await AuthService.authService.googleSignIn.disconnect();
      ref.watch(dashBoardStateProvider.notifier).navigateTo(0);
      if(context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.splashRoute, (route) => false);
      }
    }else{
      await AuthService.authService.auth.signOut();
      ref.watch(dashBoardStateProvider.notifier).navigateTo(0);
      if(context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.splashRoute, (route) => false);
      }
    }
    notifyListeners();
  }
}