import 'package:food_fly/ui/cart/mobile/helper/cart_tile.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class CartCartItem extends StatelessWidget {
  const CartCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    List item =[
      ["Avosalado","3 items • IDR 18.000.000"],
      ["Kopi Kudda","10 items • IDR 450.000"],
      ["Bwang Puttie","10 items • IDR 450.000"],
    ];
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        final data = item[index];
        return const CartTile();
    },);
  }
}
