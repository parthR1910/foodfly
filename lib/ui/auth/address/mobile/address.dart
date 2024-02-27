import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/controller/authentication/address_controller.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import '../../../../framework/service/auth_service.dart';
import 'helper/address_view.dart';

class Address extends ConsumerStatefulWidget {
  const Address({super.key});

  @override
  ConsumerState<Address> createState() => _AddressState();
}

class _AddressState extends ConsumerState<Address> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp)async {
     await ref.read(addressController).getFcmToken();
      await ref.read(addressController).getCurrentLocation();
    });
  }
  @override
  Widget build(BuildContext context,) {
    return PopScope(
      canPop: false,
      child: CommonLoading(
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
      ),
    );
  }

  AppBar _appBar(WidgetRef ref, BuildContext context) => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
            ref.read(addressController).clearForm();
          },
          icon: SvgPicture.asset(
            AppAssets.arrowBackSvg,
          ),
        ),
    automaticallyImplyLeading: false,
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
