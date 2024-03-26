import 'package:food_fly/framework/model/user_orders/user_orders_model.dart';
import 'package:food_fly/ui/cart/mobile/helper/cart_tile.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/framework/service/auth_service.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:intl/intl.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserOrdersModel>>(
        stream: FireStoreService.fireStoreService.getUserFoodOrdersFireStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final uid = AuthService.authService.auth.currentUser!.uid;
            final currentUserOrdersList = snapshot.data!
                .where(
                    (element) => element.userId == uid && !element.isDelivered!)
                .toList();
            DateTime getDateTimeFromString(String dateTime) {
              return DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateTime);
            }

            currentUserOrdersList.sort((a, b) =>
                getDateTimeFromString(b.dateTime!)
                    .compareTo(getDateTimeFromString(a.dateTime!)));
            if (currentUserOrdersList.isEmpty)
              return Center(
                child: Text('No orders yet'),
              );
            return ListView.builder(
              itemCount: currentUserOrdersList.length,
              itemBuilder: (context, index) {
                final order = currentUserOrdersList[index];
                return StreamBuilder(
                  stream: FireStoreService.fireStoreService
                      .getFoodDataByIdFireStore(order.foodId!),
                  builder: (context, snapshot) {
                    ///-------------- LOADING-----------///
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    /// -------------- DATA LOADED -------///
                    else if (snapshot.hasData) {
                      final food = snapshot.data!;
                      return currentUserOrdersList.isEmpty
                          ? const Center(
                              child: Text("Not arrived yet"),
                            )
                          : CartTile(
                              buttonText:
                                  (order.deliveryBoyId?.isNotEmpty ?? false)
                                      ? "Track order"
                                      : "Pending",
                              quantity: order.quantity!,
                              dateTime: order.dateTime,
                              paidStatus: Text(
                                  (order.paidOrNot ?? false)
                                      ? "Paid"
                                      : "Unpaid",
                                  style: AppTextStyle.w5.copyWith(
                                      fontSize: 12.sp,
                                      color: (order.paidOrNot ?? false)
                                          ? AppColors.kLightGreen
                                          : AppColors.kPrimary)),
                              onButtonTap: (order.deliveryBoyId?.isNotEmpty ??
                                      false)
                                  ? () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.customerOderDetail,
                                        arguments: {
                                          "orderId": order.uOrderId,
                                          "quantity": order.quantity,
                                          "paymentId": order.paymentId ?? '',
                                          "foodId": order.foodId,
                                          "dateTime": order.dateTime,
                                          "deliveryBoyId": order.deliveryBoyId,
                                          "isPaid": order.paidOrNot,
                                        },
                                      );
                                    }
                                  : null,
                              backgroundColor: AppColors.kPrimary,
                              foodData: food,
                              orderStatusText: "Order on the way",
                              orderStatusColor: AppColors.kPrimary,
                            );
                    }

                    ///------------ NO DATA FOUND ----------- ///
                    else {
                      return const Center(
                        child: Text("Not arrived yet"),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text("Not arrived yet"),
            );
          }
        });
  }
}
