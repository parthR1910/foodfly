import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'mobile/user_profile_mobile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const UserProfileMobile();
    });
  }
}
