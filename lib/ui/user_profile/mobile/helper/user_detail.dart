import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class UserDetails extends StatelessWidget {
  final UserModel userModel;
  const UserDetails({super.key,required this.userModel});

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
              SvgPicture.asset(AppAssets.dottedEclipSvg, height: 115.h, width: 115.w,),
              userModel.profileImage!=null? Container(
                height: 100.h,
                width: 100.w,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle
                ),
                child: CachedNetworkImage(
                  imageUrl: userModel.profileImage!,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.person),
                  fit: BoxFit.cover,
                ),
              ):
              FlutterLogo(size: 90.sp,),
            ],
          ),
        ),
      SizedBox(height: 16.h,),
      Text(userModel.name??"", style: AppTextStyle.w5.copyWith(fontSize: 18.sp, color: AppColors.kBlack),),
      SizedBox(height: 6.h,),
      Text(userModel.email??"example@gmail.com", style: AppTextStyle.w3.copyWith(fontSize: 14.sp, color: AppColors.kBlack),),
      ],
    );
  }
}
