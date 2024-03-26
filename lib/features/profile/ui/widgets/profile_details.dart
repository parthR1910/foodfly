import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/features/dashboard/controller/dashboard_controller.dart';
import 'package:food_fly_delivery_partner/features/profile/controller/profile_controller.dart';
import '../../../../common/config/theme/theme_export.dart';

class ProfileDetails extends ConsumerWidget {
  const ProfileDetails(this.userModel, {super.key});
  final UserModel userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileWatch = ref.watch(profileControllerProvider);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              children: [
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: userModel.profileImage ?? '',
                    imageBuilder: (context, imageProvider) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return InteractiveViewer(
                                child: Dialog(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    height: 400.h,
                                    width: context.screenWidth,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider)),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundImage: imageProvider,
                        )),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(color: Colors.black),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(
                    userModel.name ?? '',
                    style:
                        TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        userModel.email ?? '',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        userModel.phone ?? '',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              onTap: () {
                context.pushNamed(AppRoutes.personalDetails,
                    arguments: userModel);
              },
              title: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          /*SizedBox(height: 10.h),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              onTap: () {
                context.pushNamed(AppRoutes.bankDetails, arguments: userModel);
              },
              title: Text(
                'Bank Details',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),*/
          SizedBox(height: 10.h),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              onTap: () {
                profileWatch.showLogoutBottomSheet(context);
              },
              title: Text(
                'Log Out',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
