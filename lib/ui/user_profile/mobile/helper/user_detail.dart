import 'package:flutter_svg/svg.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(AppAssets.dottedEclipSvg, height: 110.h, width: 110.w,),
              const FlutterLogo(size: 90,),
            ],
          ),
        ),
      SizedBox(height: 16.h,),
      Text("Aashifa Sheikh", style: AppTextStyle.w5.copyWith(fontSize: 18.sp, color: AppColors.kBlack),),
      SizedBox(height: 6.h,),
      Text("contact.uiuxexperts@gmail.com", style: AppTextStyle.w3.copyWith(fontSize: 14.sp, color: AppColors.kBlack),),
      ],
    );
  }
}
