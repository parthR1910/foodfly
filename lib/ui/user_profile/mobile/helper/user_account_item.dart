import 'package:food_fly/framework/controller/profile/profile_controller.dart';
import 'package:food_fly/ui/edit_profile/edit_profile.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class UserAccountItem extends ConsumerWidget {
  const UserAccountItem({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<Map<String,dynamic>> accountTileList =[
      {"title":"Edit Profile","icon":Icons.arrow_forward_ios},
      {"title":"Home Address","icon":Icons.arrow_forward_ios},
      {"title":"Security","icon":Icons.arrow_forward_ios},
      {"title":"Payment","icon":Icons.arrow_forward_ios},
      {"title":"Contact Us","icon":Icons.arrow_forward_ios},
    ];

    final profileWatch = ref.watch(profileController);
    return Consumer(
      builder: (context, ref, child) {
        return SingleChildScrollView(
          child: Column(
            children: List.generate(accountTileList.length, (index){
              final list = accountTileList[index];
              return  ListTile(
                onTap: (){
                 profileWatch.profileAccountNavigation(index, context);
                },
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
