import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class UserAccountItem extends StatelessWidget {
  const UserAccountItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final appStringWatch = ref.watch(appStringController);
        return Column(
          children: [
            ListTile(
              title: Text(appStringWatch.keyEditProfile,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack),),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
            ListTile(
              title: Text(appStringWatch.keyHomeAddress,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
            ListTile(
              title: Text(appStringWatch.keySecurity,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
            ListTile(
              title: Text(appStringWatch.keyPayment,style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20,color: AppColors.kGrey,),
            ),
          ],
        );
      },
    );
  }
}
