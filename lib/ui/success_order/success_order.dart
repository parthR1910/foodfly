import 'package:food_fly/ui/success_order/mobile/success_order_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/theme/theme.dart';

class SuccessOrder extends StatefulWidget {
  const SuccessOrder({super.key});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context){
        return const SuccessOrderMobile();
      },
    );
  }
}
