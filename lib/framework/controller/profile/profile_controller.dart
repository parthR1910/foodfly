import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:food_fly/framework/controller/authentication/login_controller.dart';
import 'package:food_fly/ui/home_address/home_address.dart';
import 'package:food_fly/ui/privacy_policy/privacy_policy.dart';
import 'package:food_fly/ui/terms_and_condition/terms_and_condition.dart';
import 'package:food_fly/ui/user_profile/helper/logout_bottom_sheet.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

final profileController = ChangeNotifierProvider((ref) => ProfileController(ref));

class ProfileController extends ChangeNotifier {
  Ref ref;
  ProfileController(this.ref);



  profileAccountNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.editProfile);
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeAddress()));
        break;
      case 2:
        // Navigator.pushNamed(context, AppRoutes.editProfile);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Scaffold()));
        break;
      case 3:
        Future.delayed(const Duration(milliseconds: 700), () async {
          launchUrl(Uri(
            scheme: 'mailto',
            path: "parthrathod313@gmail.com",
          ));
        });
        break;
      case 4:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.question,
          animType: AnimType.rightSlide,
          title: 'Logout!',
          desc: 'Are you sure you want to logout?',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
          ref.watch(loginController).signOut(context);
          },
        ).show();
        // showBottomSheet(
        //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        //     context: context,
        //     builder: (context) => SizedBox(
        //         width: double.infinity.w,
        //         child: const LogoutBottomSheet()));
        break;
    }
  }

  adminProfileAccountNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.editProfile);
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PrivacyPolicy()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const TermsAndCondition()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Scaffold()));
        break;
      case 4:
        showModalBottomSheet(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            context: context,
            builder: (context) => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const LogoutBottomSheet()));
        break;
    }
  }

  foodMarketNavigator(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Scaffold()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PrivacyPolicy()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const TermsAndCondition()));
        break;
    }
  }
}
