import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
// import 'package:food_fly_delivery_partner/features/home/repository/home_repository.dart';
import 'package:food_fly_delivery_partner/features/profile/repository/profile_repository.dart';


final homeControllerProvider = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController();
});

class HomeController extends ChangeNotifier{
  Stream<List<OrderModel>> getOrders(BuildContext context){
    final orders = FirebaseFirestore.instance.collection("UserOrders").snapshots().map((event) => event.docs.map((e) => OrderModel.fromJson(e.data())).toList());
    print(orders.listen((event) {print(event);}));
    return orders;
  }
}

