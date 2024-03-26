import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/helper/debug_print.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
// import 'package:food_fly_delivery_partner/features/home/repository/home_repository.dart';
import 'package:food_fly_delivery_partner/features/profile/repository/profile_repository.dart';

final homeControllerProvider = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController();
});

class HomeController extends ChangeNotifier {
  List<OrderModel> ordersList = [];
  bool isLoading = false;

  Future<void> getOrdersList(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final orders =
        await FirebaseFirestore.instance.collection("UserOrders").get();
    final ordersListFromModel =
        orders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    kprint('ordersListFromModel.length');
    kprint(ordersListFromModel.length);
    ordersListFromModel.forEach(
      (order) async {
        final userModel  = await FireStoreService.fireStoreService.getUserFromUserIdFuture(order.userId);
        final foodModel  = await FireStoreService.fireStoreService.getFoodFromIdFuture(order.foodId);
        ordersList.add(OrderModel(id: order.id, foodId: order.foodId, isDelivered: order.isDelivered, paidOrNot: order.paidOrNot, qty: order.qty, userId: order.userId, deliveryBoyId: order.deliveryBoyId,foodModel: foodModel,userModel: userModel, orderDate: order.orderDate));
        notifyListeners();
      }
    );
    isLoading = false;
    notifyListeners();
  }

  Stream<List<OrderModel>> getOrders() {
    final orders = FirebaseFirestore.instance
        .collection("UserOrders")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => OrderModel.fromJson(e.data())).toList());
    return orders;
  }
}
