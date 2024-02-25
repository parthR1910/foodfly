import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/data_types.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

import '../repository/login_repository.dart';

final loginController = ChangeNotifierProvider((ref) => LoginController());

class LoginController extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loading = false;
  login(BuildContext context) async {
    if (loginKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      String message = await LoginRepository.loginWithEmailAndPass(emailController.text, passController.text);
      if (context.mounted) {
        if (message== 'Login SuccessFully') {
          Fluttertoast.showToast(msg: 'Login Successfully');
          context.pushAndRemoveUntilNamed(AppRoutes.dasboard);
        } else {
          context.showSnackBar(message);
        }
      }
      loading = false;
      notifyListeners();
    }
  }
}
