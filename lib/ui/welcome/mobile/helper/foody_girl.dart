import 'package:food_fly/ui/utils/theme/app_assets.dart';

import '../../../utils/theme/theme.dart';

class FoodGirl extends StatelessWidget {
  const FoodGirl({super.key});

  @override
  Widget build(BuildContext context) =>
      // SizedBox(
      //   height: 289.h,
      //   width: 200.w,
      //   child: FlutterLogo(),
      // );
      Image.asset(
        AppAssets.girlWithFood,
        height: 289.h,
        width: 200.h,
      );
  // SvgPicture.asset(AppAssets.foodyGirlSvg, height: 289.h, width: 200.w);
}
