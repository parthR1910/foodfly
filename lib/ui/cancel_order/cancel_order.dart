import 'package:food_fly/ui/cancel_order/mobile/cancel_order_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/theme/theme.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({super.key});

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context){
        return const CancelOrderMobile();
      },
    );
  }
}
