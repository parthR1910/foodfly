import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_string.dart';
import '../../../utils/theme/app_text_style.dart';

class UserFoodMarketDetails extends StatelessWidget {
  const UserFoodMarketDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final appStringWatch = ref.watch(appStringController);
        return Column(
          children: [
            ListTile(
              title: Text(appStringWatch.keyRateApp,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack),),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
            ListTile(
              title: Text(appStringWatch.keyHelpCenter,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
            ListTile(
              title: Text(appStringWatch.keyPrivacyPolicy,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
            ListTile(
              title: Text(appStringWatch.keyTermsConditions,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
          ],
        );
      },
    );
  }
}
