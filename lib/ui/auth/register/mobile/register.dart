import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_fly/framework/controller/authentication/register_controller.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_string.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';
import 'helper/register_view.dart';

class Register extends ConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    final registerWatch = ref.watch(registerController);
    return PopScope(
      canPop: registerWatch.loading ? false : true,
      child: CommonLoading(
        show: registerWatch.loading,
        child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: _appBar(ref, context),
          body: const RegisterView(),
        ),
      ),),
    );
  }

  AppBar _appBar(WidgetRef ref, BuildContext context) => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            AppAssets.arrowBackSvg,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ref.watch(appStringController).keySignUp,
                style: AppTextStyle.w5
                    .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
            Text(ref.watch(appStringController).keyRegisterAndEat,
                style: AppTextStyle.w3
                    .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
          ],
        ),
      );
}
