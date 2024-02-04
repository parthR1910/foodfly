import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class UserAccountItem extends StatelessWidget {
  const UserAccountItem({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> accountTileList =[
      {"title":"Edit Profile","icon":Icons.arrow_forward_ios},
      {"title":"Home Address","icon":Icons.arrow_forward_ios},
      {"title":"Security","icon":Icons.arrow_forward_ios},
      {"title":"Payment","icon":Icons.arrow_forward_ios},
      {"title":"Contact Us","icon":Icons.arrow_forward_ios},
    ];
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          children: List.generate(accountTileList.length, (index){
            final list = accountTileList[index];
            return  ListTile(
              onTap: (){},
              title: Text(list["title"],style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
              trailing:  Icon(list["icon"], size: 20,color: AppColors.kGrey,),
            );
          })
        );
      },
    );
  }
}
