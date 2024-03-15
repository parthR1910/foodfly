import 'package:food_fly/framework/controller/profile/profile_controller.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../../framework/service/shared_pref_services.dart';
import '../../../utils/constant/app_const_list.dart';

class UserAccountItem extends ConsumerWidget {
  const UserAccountItem({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<Map<String,dynamic>> accountTileList =[
      {"title":"Edit Profile","icon":Icons.arrow_forward_ios},
      {"title":"Home Address","icon":Icons.arrow_forward_ios},
      {"title":"Payment","icon":Icons.arrow_forward_ios},
      {"title":"Contact Us","icon":Icons.arrow_forward_ios},
      {"title":"Log out","icon":Icons.arrow_forward_ios},
    ];

    List<Map<String,dynamic>> adminAccTileList =[
      {"title":"Edit Profile","icon":Icons.arrow_forward_ios},
      {"title":"Privacy & Policy","icon":Icons.arrow_forward_ios},
      {"title":"Terms & Condition","icon":Icons.arrow_forward_ios},
      {"title":"Rate App","icon":Icons.arrow_forward_ios},
      {"title":"Log out","icon":Icons.arrow_forward_ios},
    ];

    final profileWatch = ref.read(profileController);
    return Consumer(
      builder: (context, ref, child) {
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
                SharedPrefServices.services.getBool(isAdminKey)?adminAccTileList.length: accountTileList.length,
                    (index){
              final list = SharedPrefServices.services.getBool(isAdminKey)?adminAccTileList[index]:accountTileList[index];
              return  ListTile(
                onTap: (){
                  SharedPrefServices.services.getBool(isAdminKey)?
                  profileWatch.adminProfileAccountNavigation(index, context):
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
