import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import '../../../../framework/model/food_data_model/food_data_model.dart';
import '../../../../framework/model/user_orders/user_orders_model.dart';
import '../../../../framework/service/auth_service.dart';
import '../../../../framework/service/fire_store_service.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_text_style.dart';
import 'cart_tile.dart';

class CartPastOrderItem extends StatelessWidget {
  const CartPastOrderItem({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<UserOrdersModel>>(
        stream: FireStoreService.fireStoreService.getUserFoodOrdersFireStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasData) {
            final uid = AuthService.authService.auth.currentUser!.uid;
            final currentUserPastOderList = snapshot.data!.where((element) => element.userId == uid && element.isDelivered!).toList();

            return ListView.builder(
              itemCount: currentUserPastOderList.length,
              itemBuilder: (context, index) {
                final order = currentUserPastOderList[index];
                return StreamBuilder(
                stream: FireStoreService.fireStoreService.getFoodDataByIdFireStore(order.foodId!),
                builder: (context, snapshot) {
                  ///-------------- LOADING-----------///
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  /// -------------- DATA LOADED -------///
                  else if(snapshot.hasData){
                   final foodData = snapshot.data!;
                    return currentUserPastOderList.isEmpty?
                    const Center(child: Text("ADD data to cart"),):
                    CartTile(
                      buttonText: "Order again",
                      quantity: order.quantity??1,
                      dateTime: order.dateTime,
                      onButtonTap: (){
                        Navigator.pushNamed(context, AppRoutes.foodDetail,arguments: foodData);
                      },
                      backgroundColor: AppColors.kLightGreen,
                      foodData: foodData,
                      paidStatus: Text("Paid",style: AppTextStyle.w5.copyWith(fontSize: 16.sp,color:AppColors.kLightGreen)),
                      orderStatusText: "Successfully delivered",
                      orderStatusColor: AppColors.kLightGreen,
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
