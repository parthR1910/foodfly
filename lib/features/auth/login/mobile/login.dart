import 'package:flutter/scheduler.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/common_loading.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/login_controller.dart';
import 'package:food_fly_delivery_partner/features/auth/login/mobile/helper/login_view.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context,) {
    return CommonLoading(
        show: ref.watch(loginController).loading, child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        body: LoginView(),
      ),
    ));
  }
}
