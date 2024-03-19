import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/cart/mobile/helper/cart_tile.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../../framework/service/fire_store_service.dart';

class CartUpComing extends StatelessWidget {
  const CartUpComing({super.key});

  @override
  Widget build(BuildContext context) {
    List item =[
      ["Avosalado","3 items • IDR 18.000.000"],
      ["Kopi Kudda","10 items • IDR 450.000"],
      ["Es Tong-Tong","2 items • IDR 900.500"],
      ["Bwang Puttie","10 items • IDR 450.000"],
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
