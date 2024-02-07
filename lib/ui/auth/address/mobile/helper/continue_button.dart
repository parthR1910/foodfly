import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:food_fly/ui/utils/widgets/helper.dart';
import 'package:food_fly/framework/controller/authentication/address_controller.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../../welcome/mobile/welcome.dart';

class ContinueButton extends ConsumerWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    final addressWatch = ref.watch(addressController);
    return CommonButton(
      onTap: ()async {
        if(addressWatch.addressKey.currentState!.validate()){
          if(addressWatch.fullAddress.isEmpty){
            showSnackBar(context: context, error: "Enter your Location");
          }else{
           await addressWatch.updateDataToFireStore();
           addressWatch.clearForm();
            // ignore: use_build_context_synchronously
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Welcome()));
          }
        }

      },
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        appString.keyContinue,
        style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
      ),
    );
  }
}
