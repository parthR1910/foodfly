import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import '../../utils/theme/theme.dart';
import 'helper/home_view.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mobileDeviceConfig(context);
    final appString = ref.watch(appStringController);
    return Scaffold(
      appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appString.keyFoodFly,
                  style: AppTextStyle.w5.copyWith(
                    fontSize: 22.sp,
                  )),
              Text(
                appString.keyLetsGetSomeFoods,
                style: AppTextStyle.w3
                    .copyWith(fontSize: 14.sp, color: AppColors.kGrey),
              )
            ],
          ),
          actions: [
            Container(
              height: 50.h,
              width: 50.w,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(8.r)),
              child: const Icon(Icons.person),
            ),
          ]),
      body: const HomeView(),
    );
  }
}
