import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/framework/service/notificaion_service.dart';
import 'package:food_fly/ui/utils/extension/context_extension.dart';
import 'package:uuid/uuid.dart';

import '../../../ui/utils/theme/theme.dart';
import '../../model/food_cart_model/food_cart_model.dart';
import '../../model/user_orders/user_orders_model.dart';
import '../../service/auth_service.dart';

final cartController = ChangeNotifierProvider((ref) => CartController());

class CartController extends ChangeNotifier {
  removeCartDataFromFirebase(String foodId) async {
    try {
      await FireStoreService.fireStoreService.removeFoodCartData(foodId);
    } catch (e) {
      Future.error(e.toString());
    }
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(now);
  }

  Future postUserFoodOrder(
      {required int quantity,
      required String foodId,
      required String paymentId,
      required bool paidOrNot}) async {
    notifyListeners();
    Uuid uuid = const Uuid();
    String uOrderId = uuid.v4();
    final userId = AuthService.authService.auth.currentUser!.uid;
    final UserOrdersModel userOrdersModel = UserOrdersModel(
      quantity: quantity,
      foodId: foodId,
      paidOrNot: paidOrNot,
      uOrderId: uOrderId,
      userId: userId,
      isDelivered: false,
      dateTime: getCurrentDateTime(),
    );
    await FireStoreService.fireStoreService
        .postUserFoodOrderToFireStore(userOrdersModel);
    notifyListeners();
    return uOrderId;
  }

  Future<void> cancelOrder(String orderId, BuildContext context,
      String? paymentId, String deliveryBoyId) async {
    final deliveryBoyData = await FireStoreService.fireStoreService.fireStore
        .collection('User')
        .doc(deliveryBoyId)
        .get();

    await FireStoreService.fireStoreService.fireStore
        .collection('UserOrders')
        .doc(orderId)
        .delete();
    if (paymentId != null && paymentId.isNotEmpty) {
      await FireStoreService.fireStoreService.fireStore
          .collection('userPayment')
          .doc(paymentId)
          .delete();
    }
    // NotificationService.sendNotification(, title, body)
    AwesomeDialog(
        context: context,
        onDismissCallback: (type) {
          if (type == DismissType.modalBarrier) {
            context.pop();
          }
        },
        dialogType: DialogType.success,
        titleTextStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        title: 'Order cancel successfully',
        btnOkOnPress: () {
          context.pop();
        }).show();
  }
}
