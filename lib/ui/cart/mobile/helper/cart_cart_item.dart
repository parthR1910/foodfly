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

    return StreamBuilder<List<FoodCartModel>>(
        stream: FireStoreService.fireStoreService.getUserFoodCartOrdersFireStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasData) {
            final uid = AuthService.authService.auth.currentUser!.uid;
            final foodCartList = snapshot.data!;
            final List<String> cUserFoodIdList = [];
            final List<int> foodQuantity = [];
            for (var i in foodCartList) {
              if (i.userId == uid) {
                cUserFoodIdList.add(i.foodId!);
                foodQuantity.add(i.quantity!);
              }
            }
            return StreamBuilder(
              stream: FireStoreService.fireStoreService.getFoodDataFireStore(),
              builder: (context, snapshot) {
                ///-------------- LOADING-----------///
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }

                /// -------------- DATA LOADED -------///
                else if(snapshot.hasData){
                  List<FoodDataModel> foodDataModel = [];
                  ///------- food list ----///
                for(var foodData in snapshot.data!){
                  for(var cUserFid in cUserFoodIdList){
                    if(cUserFid == foodData.foodId){
                      foodDataModel.add(foodData);
                    }}}
                  return foodDataModel.isEmpty?
                      const Center(child: Text("ADD data to cart"),):
                   ListView.builder(
                    itemCount: foodDataModel.length,
                    itemBuilder: (context, index) {
                      final foodData = foodDataModel[index];
                      final foodQnt = foodQuantity[index];
                      return  CartTile(
                        buttonText: "Order now",
                        quantity: foodQnt,
                        onButtonTap: (){},
                        backgroundColor: AppColors.kPrimary,
                        foodData: foodData,
                        orderStatusText: "Order this food",
                        orderStatusColor: AppColors.orangeColor,
                      );
                    },);
                }

                ///------------ NO DATA FOUND ----------- ///
                else{
                  return const Center(
                    child: Text("No data available"),
                  );
                }
              },
            );
          } else {
            return const Center(
              child: Text("No data available"),
            );
          }
        });
  }
}
