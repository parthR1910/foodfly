import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/helper/ui_helper.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../common/model/user_model.dart';

final loginController = ChangeNotifierProvider((ref) => LoginController(ref));

class LoginController extends ChangeNotifier {
  Ref ref;
  LoginController(this.ref);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetPassEmailController = TextEditingController();
  bool loading = false;
  bool isPassNotShow = true;
  bool isGoogleLogin = false;

  updatesIsPassNotShow() {
    isPassNotShow = !isPassNotShow;
    notifyListeners();
  }

  Future signInWithEmailAndPassword(BuildContext context) async {
    loading = true;
    final authResponse = await AuthService.authService
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
    if (authResponse.user != null) {
      final uid = AuthService.authService.auth.currentUser!.uid;
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await FireStoreService.fireStoreService.fireStore
          .collection("User")
          .doc(uid)
          .update({'fcmToken': fcmToken ?? ''});
      loading = false;

      notifyListeners();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.dashboard, (route) => false);
      }
    } else {
      loading = false;
      if (context.mounted) {
        showSnackBar(context: context, error: authResponse.error!);
      }
    }
    notifyListeners();
  }

  clearForm() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    if (isGoogleLogin) {
      isGoogleLogin = false;
      await AuthService.authService.googleSignIn.disconnect();
      // ref.watch(dashBoardStateProvider.notifier).navigateTo(0);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.splash, (route) => false);
      }
    } else {
      await AuthService.authService.auth.signOut();
      // ref.watch(dashBoardStateProvider.notifier).navigateTo(0);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.splash, (route) => false);
      }
    }
    notifyListeners();
  }
}
