
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/comp/compatibility_profile_controller.dart';
import 'package:food_fly_delivery_partner/features/splash/splash.dart';
import 'package:get/get.dart';

class CompatibilityAnswerScreen extends StatelessWidget {
  
  const CompatibilityAnswerScreen(
      {super.key, required this.compatibilityAnswer, required this.title});
  final CompatibilityAnswer compatibilityAnswer;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GetBuilder<CompatibilityProfileController>(
        builder: (compatibilityController) {
          List<String> selctedList =
              compatibilityAnswer.seekerAnswer?.value ?? [];
          List<String> unSelctedList =
              compatibilityAnswer.seekingAnswer?.value ?? [];
          return SingleChildScrollView(
            child: Column(
              children: [
                ...[...selctedList, ...unSelctedList]
                    .toSet()
                    .toList()
                    .map((e) => CheckboxListTile(
                          value: selctedList.contains(e),
                          title: Text(e),
                          onChanged: (value) {
                            compatibilityController.onToggleAnswerSelection(
                                title, e, value ?? false);
                          },
                        ))
              ],
            ),
          );
        },
      ),
    );
  }
}