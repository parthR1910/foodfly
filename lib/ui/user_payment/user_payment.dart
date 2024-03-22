import 'package:food_fly/ui/user_payment/helper/user_payment_order_item.dart';
import '../utils/theme/theme.dart';

class UserPayment extends StatelessWidget {
  const UserPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment"),),
      body: const Column(
        children: [
       Expanded(child: UserPaymentOrderItem())
        ],
      ),
    );
  }
}
