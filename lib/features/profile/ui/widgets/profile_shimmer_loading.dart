import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/shimmer_widget.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/widgets/log_out_dialog.dart';
import '../../../../common/config/theme/theme_export.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading( {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.grey.shade200,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              children: [

                ListTile(
                  leading:                          ShimmerWidget(height: 80.h, width: 80.w
                    ,isCircle: true),
                  title:                           ShimmerWidget(height: 24.h, width: 100.w),
                  subtitle:                           Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h,),
                      ShimmerWidget(height: 21.h, width: 100.w),
                      SizedBox(height: 8.h,),
                      ShimmerWidget(height: 21.h, width: 100.w),
                    ]
                  ),

                ),
              ],
            ),
          ),
          SizedBox(height: 30.h,),

ShimmerWidget(height: 50, width: double.infinity,borderRadius: 15.r),
          SizedBox(height: 20.h,),

          ShimmerWidget(height: 50, width: double.infinity,borderRadius: 15.r),
          SizedBox(height: 20.h,),

          ShimmerWidget(height: 50, width: double.infinity,borderRadius: 15.r),

        ],
      ),
    );
  }
}
