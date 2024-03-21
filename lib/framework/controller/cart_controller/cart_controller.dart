

import 'package:easy_localization/easy_localization.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:uuid/uuid.dart';

import '../../../ui/utils/theme/theme.dart';
import '../../model/food_cart_model/food_cart_model.dart';
import '../../model/user_orders/user_orders_model.dart';
import '../../service/auth_service.dart';

final cartController = ChangeNotifierProvider((ref) => CartController());

class CartController extends ChangeNotifier{




  removeCartDataFromFirebase(String foodId) async{
    try{
      await FireStoreService.fireStoreService.removeFoodCartData(foodId);
    }catch (e){
      Future.error(e.toString());
    }
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(now);
  }
  Future postUserFoodOrder({required int quantity, required String foodId,required bool paidOrNot}) async {
    notifyListeners();
    Uuid uuid = const Uuid();
    String uniqueId = uuid.v4();
    final userId = AuthService.authService.auth.currentUser!.uid;
    final UserOrdersModel userOrdersModel = UserOrdersModel(
      quantity: quantity,
      foodId: foodId,
      paidOrNot: paidOrNot,
      uOrderId: uniqueId,
      userId: userId,
      isDelivered: false,
      dateTime:getCurrentDateTime(),
    );
    await FireStoreService.fireStoreService
        .postUserFoodOrderToFireStore(userOrdersModel);
    notifyListeners();
  }
}