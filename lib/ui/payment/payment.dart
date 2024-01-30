import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'mobile/payment_mobile.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context){
        return const PaymentMobile();
      }

    );
  }
}
