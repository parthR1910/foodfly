import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import '../../../framework/service/auth_service.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/theme.dart';

class SplashMobile extends StatefulWidget {
  const SplashMobile({super.key});

  @override
  State<SplashMobile> createState() => _SplashMobileState();
}

class _SplashMobileState extends State<SplashMobile> {
  @override
  void initState() {
    super.initState();
    // authStatus(context);
    Future.delayed(
      1.seconds,
      () {
        authStatus(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mobileDeviceConfig(context);

    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: _body(),
    );
  }

  Center _body() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.splashSvg,
          height: 100,
          width: 100,
        ).animate().slideY(duration: 1500.ms).fade(duration: 1500.ms),
        const SizedBox(height: 30),
        Consumer(builder: (context, ref, child) {
          return Text(ref.watch(appStringController).keyFoodFly,
                  style: AppTextStyle.w5
                      .copyWith(color: Colors.white, fontSize: 32.sp))
              .animate()
              .slideY(
                duration: 1500.ms,
              )
              .move(begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
              .fade(duration: 1500.ms);
        })
      ],
    ));
  }
}

Future<void> authStatus(BuildContext context)async{
  final user = AuthService.authService.auth.currentUser;
  if(user != null){
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false);
  }else{
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signInRoute, (route) => false);
  }
}