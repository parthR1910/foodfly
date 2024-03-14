import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_text_style.dart';
import 'cart_tile.dart';

class CartPastOrderItem extends StatelessWidget {
  const CartPastOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    List item =[
      ["Kari Sleman","1 item • IDR 289.000","Jun 12, 14:00",""],
      ["Avosalado","1 item • IDR 6.000.000","Mei 2, 09:00","Cancelled"],
    ];
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        final data = item[index];
        return const CartTile();
      },);
  }
}
