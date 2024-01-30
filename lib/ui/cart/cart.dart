import 'package:food_fly/ui/cart/mobile/cart_mobile.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context){
        return const CartMobile();
      },
    );
  }
}
