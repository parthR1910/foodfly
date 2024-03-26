import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/features/profile/controller/profile_controller.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/widgets/profile_details.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/widgets/profile_shimmer_loading.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileWatch = ref.read(profileControllerProvider);
    return StreamBuilder(
      stream: profileWatch.getProfileDetailsStream(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProfileShimmerLoading();
        } else if (snapshot.hasData) {
          return ProfileDetails(snapshot.data!);
        }
        return Center(
          child: Text(
            'No Record Found',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        );
      },
    );
  }
}
