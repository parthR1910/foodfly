import 'package:food_fly/ui/success_order/mobile/find_foods_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/theme/theme.dart';

class FindFoods extends StatefulWidget {
  const FindFoods({super.key});

  @override
  State<FindFoods> createState() => _FindFoodsState();
}

class _FindFoodsState extends State<FindFoods> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context){
        return const FindFoodsMobile();
      },
    );
  }
}
