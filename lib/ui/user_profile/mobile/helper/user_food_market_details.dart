import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

class UserFoodMarketDetails extends StatelessWidget {
  const UserFoodMarketDetails({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> accountTileList =[
      {"title":"Rate Ap","icon":Icons.arrow_forward_ios},
      {"title":"Help Center","icon":Icons.arrow_forward_ios},
      {"title":"Privacy & Policy","icon":Icons.arrow_forward_ios},
      {"title":"Terms & Condition","icon":Icons.arrow_forward_ios},
    ];
    return Consumer(
      builder: (context, ref, child) {
        return SingleChildScrollView(
          child: Column(
              children: List.generate(accountTileList.length, (index){
                final list = accountTileList[index];
                return  ListTile(
                  onTap: (){},
                  title: Text(list["title"],style: AppTextStyle.w4.copyWith(fontSize: 14.sp, color: AppColors.kBlack)),
                  trailing:  Icon(list["icon"], size: 20,color: AppColors.kGrey,),
                );
              })
          ),
        );
      },
    );
  }
}
