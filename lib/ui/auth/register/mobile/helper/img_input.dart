import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/controller/authentication/register_controller.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import '../../../../utils/theme/app_assets.dart';
import '../../../../utils/theme/theme.dart';

class ImgInput extends ConsumerWidget {
  const ImgInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    final registerWatch = ref.watch(registerController);
    return SizedBox(
      height: 110.h,
      width: 110.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: SvgPicture.asset(AppAssets.dottedEclipSvg)),
          GestureDetector(
            onTap: () {
              registerWatch.pickImageFile(context);
            },
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: CircleAvatar(
                radius: 90.r,
                backgroundColor: Colors.grey.shade200,
                child:registerWatch.selectedFile !=null?
                    ClipOval(child: Container(
                      height: 90.h,
                        width: 90.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: Image.file(registerWatch.selectedFile!,fit: BoxFit.cover,))):
                Text(
                  appString.keyAddPhoto,
                  style: AppTextStyle.w3
                      .copyWith(color: AppColors.kGrey, fontSize: 14.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
