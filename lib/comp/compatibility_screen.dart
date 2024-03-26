import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/comp/compatibility_ans_screen.dart';
import 'package:food_fly_delivery_partner/comp/compatibility_profile_controller.dart';
import 'package:food_fly_delivery_partner/features/splash/splash.dart';
import 'package:get/get.dart';

class CompatibilityProfileScreen extends StatefulWidget {
  const CompatibilityProfileScreen({super.key});

  @override
  State<CompatibilityProfileScreen> createState() =>
      _CompatibilityProfileScreenState();
}

class _CompatibilityProfileScreenState
    extends State<CompatibilityProfileScreen> {
  @override
  void initState() {
    super.initState();
    contorller.init();
  }

  final contorller = Get.put(CompatibilityProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.primaryColor,
      body: RefreshIndicator(
        onRefresh: () async {
          return contorller.init();
        },
        child: SafeArea(
          child: GetBuilder<CompatibilityProfileController>(
              builder: (compatibilityController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          compatibilityController.checkAndUpdateDataToServer();
                        },
                        icon: const Icon(Icons.close)),
                    IconButton(
                        onPressed: () {
                          compatibilityController.init();
                        },
                        icon: const Icon(Icons.refresh)),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...compatibilityController.compatibilityAnswers.entries
                            .map((e) => ListTile(
                                  onTap: () => context.push(
                                      CompatibilityAnswerScreen(
                                          compatibilityAnswer: e.value,
                                          title: e.key)),
                                  title: Text(e.key ?? ''),
                                ))
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
