import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/controler/authentication/address_controller.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';

import '../../../utils/theme/app_assets.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_string.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';
import 'helper/address_view.dart';

class AddressMobile extends ConsumerWidget {
  const AddressMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    return CommonLoading(
      show: ref.watch(addressController).loading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: _appBar(ref, context),
          body: const AddressView(),
        ),
      ),
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
            Text(ref.watch(appStringController).keyAddress,
                style: AppTextStyle.w5
                    .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
            Text(ref.watch(appStringController).keyMakeSureItsValid,
                style: AppTextStyle.w3
                    .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
          ],
        ),
      );
}
