import 'package:food_fly/ui/dashboard/dashboard.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:food_fly/ui/welcome/mobile/helper/greeting_text.dart';

import 'helper/foody_girl.dart';

class WelcomeMobile extends StatelessWidget {
  const WelcomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    mobileDeviceConfig(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [const FoodGirl(), const GreetingText(), findFoodButton],
          ),
        ),
      ),
    );
  }

  get findFoodButton => Consumer(builder: (context, ref, child) {
        final appString = ref.watch(appStringController);
        return CommonButton(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashBoard(),
                ),
                (route) => false,
              );
            },
            child: Text(appString.keyFindFoods));
      });
}
