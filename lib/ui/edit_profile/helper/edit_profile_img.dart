import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly/framework/controller/profile/edit_profile_controller/edit_profile_controller.dart';

import '../../utils/theme/theme.dart';

class EditProfileImg extends ConsumerWidget {
  const EditProfileImg({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editProfileWatch = ref.watch(editProfileController);

    return GestureDetector(
        onTap: () {
          editProfileWatch.pickImageFile(context);
        },
        child: Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r)
          ),
          child: Container(
            width: 120.h,
            height: 120.w,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffD6D6D6)),
            child:editProfileWatch.profileImgUrl!=""?
                editProfileWatch.selectedFile!=null?
                    Image.file(editProfileWatch.selectedFile!, fit: BoxFit.cover,):
            CachedNetworkImage(
              imageUrl: editProfileWatch.profileImgUrl,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.person),
              fit: BoxFit.cover,
            ):
            Center(
              child: Icon(
                Icons.camera_alt_outlined,
                size: 40.sp,
                color: Colors.white,
              ),
            ),
          ),
        )
    );
  }
}
