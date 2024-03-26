
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_assets.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/register_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImgInput extends ConsumerWidget {
  const ImgInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerWatch = ref.watch(registerController);
    return SizedBox(
      height: 110.h,
      width: 110.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(AppAssets.dottedEclipSvg),
          GestureDetector(
            onTap: () {
              registerWatch.pickImageFile(context);
            },
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: CircleAvatar(
                radius: 110.r,
                backgroundColor: Colors.grey.shade200,
                child:registerWatch.selectedFile !=null?
                    ClipOval(child: Container(
                      height: 100.h,
                        width: 100.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: Image.file(registerWatch.selectedFile!,fit: BoxFit.cover,))):
                Text(
                  'Add Photo',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
