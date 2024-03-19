import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../../framework/service/fire_store_service.dart';
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
    return StreamBuilder(
        stream: FireStoreService.fireStoreService.getFoodDataFireStore(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final foodData = snapshot.data![index];
                return  CartTile(foodData: foodData,);
              },);
          }else{
            return const Center(child: Text("Order food now"),);
          }

        }
    );
  }
}
