import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/address_controller.dart';

import '../../../../../common/utils/helper/ui_helper.dart';

class ContinueButton extends ConsumerWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressWatch = ref.watch(addressController);
    return CommonButton(
      onTap: () async {
        if (addressWatch.addressKey.currentState!.validate()) {
          // if(addressWatch.fullAddress.isEmpty){
          // showSnackBar(context: context, error: "Enter your Location");
          // }else{
          await addressWatch.updateDataToFireStore();
          addressWatch.clearForm();
          // ignore: use_build_context_synchronously
          context.pushAndRemoveUntilNamed(AppRoutes.dashboard);
          // }
        }
      },
      padding: EdgeInsets.symmetric(vertical: 12.h),
      btnText: 'Continue',
    );
  }
}
