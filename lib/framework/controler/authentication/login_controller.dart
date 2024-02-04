import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/helper.dart';

import '../../service/auth_service.dart';

final loginController  = ChangeNotifierProvider((ref) => LoginController());

class LoginController extends ChangeNotifier{

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

  Future<void> signOut()async{
    if(isGoogleLogin){
      isGoogleLogin = false;
      await AuthService.authService.googleSignIn.disconnect();
    }
    await AuthService.authService.auth.signOut();
    notifyListeners();
  }
}