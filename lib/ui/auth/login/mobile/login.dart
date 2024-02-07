import 'package:flutter/scheduler.dart';
import 'package:food_fly/framework/controller/authentication/login_controller.dart';
import 'package:food_fly/framework/service/hive_service/box_service.dart';
import 'package:food_fly/ui/auth/login/mobile/helper/login_view.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';
import '../../../utils/theme/theme.dart';

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
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      BoxService.boxService.clearAllBoxes();
    });
  }
  @override
  Widget build(BuildContext context,) {
    mobileDeviceConfig(context);
    return CommonLoading(
        show: ref.watch(loginController).loading, child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ref.watch(appStringController).keySignIn,
                  style: AppTextStyle.w5
                      .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
              Text(ref.watch(appStringController).keyFindYourBestMeal,
                  style: AppTextStyle.w3
                      .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
            ],
          ),
        ),
        body: const LoginView(),
      ),
    ));
  }
}
