import 'package:food_fly/framework/model/food_cart_model/food_cart_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/ui/cart/mobile/helper/cart_cart_item/cart_cart_tile.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/framework/service/auth_service.dart';


class CartCartItem extends ConsumerWidget {
  const CartCartItem({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
final mainContext = context;
    return StreamBuilder<List<FoodCartModel>>(
        stream: FireStoreService.fireStoreService.getUserFoodCartOrdersFireStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasData) {
            final uid = AuthService.authService.auth.currentUser!.uid;
            final foodCartList = snapshot.data!.where((element) => element.userId == uid).toList();
            return ListView.builder(
              itemCount: foodCartList.length,
              itemBuilder: (context, index) {
                final order =foodCartList[index];
                return StreamBuilder(
                  stream: FireStoreService.fireStoreService.getFoodDataByIfFireStore(order.foodId!),
                  builder: (context, snapshot) {
                    ///-------------- LOADING-----------///
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    /// -------------- DATA LOADED -------///
                    else if(snapshot.hasData){
                      final foodData = snapshot.data!;
                      return foodCartList.isEmpty?
                      const Center(child: Text("ADD data to cart"),):
                      CartCartTile(foodData: foodData, order: order,parenteContext: mainContext,);
                    }
                    ///------------ NO DATA FOUND ----------- ///
                    else{
                      return const Center(
                        child: Text("No data available"),
                      );
                    }
                  },
                );
              },);
          } else {
            return const Center(
              child: Text("No data available"),
            );
          }
        });
  }
}
