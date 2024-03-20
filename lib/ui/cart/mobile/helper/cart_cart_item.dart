import 'package:food_fly/framework/model/food_cart_model/food_cart_model.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import '../../../../framework/service/auth_service.dart';
import 'cart_tile.dart';

class CartCartItem extends StatelessWidget {
  const CartCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    // stream: FireStoreService.fireStoreService.getUserFoodCartOrdersFireStore(),

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
                final order = foodCartList[index];
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
                    CartTile(
                      buttonText: "Order now",
                      quantity: order.quantity!,
                      dateTime: order.dateTime,
                      onButtonTap: (){},
                      backgroundColor: AppColors.orangeColor,
                      foodData: foodData,
                      orderStatusText: "Order this food",
                      orderStatusColor: AppColors.orangeColor,
                    );
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
