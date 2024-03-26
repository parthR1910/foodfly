import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/food_model.dart';
import 'package:food_fly_delivery_partner/common/model/notification_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/date_time_formater.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_base_singleton.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/notification_service.dart';
// import 'package:food_fly_delivery_partner/features/home/repository/home_repository.dart';
import 'package:food_fly_delivery_partner/features/profile/repository/profile_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

final orderDetailControllerProvider =
    ChangeNotifierProvider<OrderDetailController>((ref) {
  return OrderDetailController();
});

class OrderDetailController extends ChangeNotifier {
  String confirmOrderOTP = '';

  Stream<List<OrderModel>> getOrders(BuildContext context) {
    final orders = FirebaseFirestore.instance
        .collection("UserOrders")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => OrderModel.fromJson(e.data())).toList());
    return orders;
  }

  Stream<OrderDetailModel> orderDetailStream(
      String uid, String foodId, String orderId) {
    final firestoreService = FireStoreService.fireStoreService;
    print('orderId');
    print(orderId);
    final order = FirebaseFirestore.instance
        .collection("UserOrders")
        .doc(orderId)
        .snapshots()
        .map((event) => OrderModel.fromJson(event.data() ?? {}));

    return Rx.combineLatest3(
        firestoreService.getUserFromUserId(uid),
        firestoreService.getFoodFromId(foodId),
        order,
        (userStream, foodStream, orderModelStream) =>
            OrderDetailModel(foodStream, userStream, orderModelStream));
  }

  Future<OrderDetailModel> orderDetailFromFuture(
      String uid, String foodId, OrderModel orderModel) async {
    final firestoreService = FireStoreService.fireStoreService;
    final foodModel = await firestoreService.getFoodFromIdFuture(foodId);
    final userModel = await firestoreService.getUserFromUserIdFuture(uid);
    return OrderDetailModel(foodModel, userModel, orderModel);
  }

  confirmOrder(BuildContext context, String orderId) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            title: 'Are You Sure To Accept this order',
            titleTextStyle:
                TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            btnOkOnPress: () async {
              await FireStoreService.fireStoreService.fireStore
                  .collection('UserOrders')
                  .doc(orderId)
                  .update({
                'deliveryBoyId': AuthService.authService.auth.currentUser?.uid
              }).then((value) {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    title: 'Order Accepted Successfully',
                    titleTextStyle:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                    btnOkOnPress: () {
                      context.pop();
                    }).show();
              });
              startLiveLocation();
            },
            btnCancelOnPress: () {})
        .show();
  }

  startLiveLocation() {
    Geolocator.getPositionStream().listen((event) async {
      FireStoreService.fireStoreService.updateUserLocation(
          LatLong(latitude: event.latitude, longitude: event.longitude));
    });
  }

  Future<void> generateOTP(
      String orderId, String userFCMTOKEN, String userId) async {
    String otp = (1000 + Random().nextInt(9000)).toString();
    const title = 'Order Confirmation OTP';
    final body =
        ' Your confirmation OTP $otp Thank you for placing your order with us. To confirm your order 🙏...';
    await FirebaseSingleTon.firebaseSingleTon.fireStore
        .collection('UserOrders')
        .doc(orderId)
        .update({'confirmationOTP': otp});
    await NotificationService.sendNotification(userFCMTOKEN, title, body);

    final docRef = await FirebaseSingleTon.firebaseSingleTon.fireStore
        .collection('Notifications')
        .add(NotificationDataModel(
                id: '',
                title: title,
                body: body,
                uid: userId,
                dateTime:
                    DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()))
            .toJson());
    final id = docRef.id;
    await docRef.update({'id': id});
  }

  Future<void> verifyOtp(
      String? firstoreOtp, String orderId, BuildContext context) async {
    if (firstoreOtp == null || firstoreOtp.isEmpty) {
      Fluttertoast.showToast(
          gravity: ToastGravity.CENTER, msg: 'Please Generate OTP First');
    } else {
      if (confirmOrderOTP == firstoreOtp) {
        await FirebaseSingleTon.firebaseSingleTon.fireStore
            .collection('UserOrders')
            .doc(orderId)
            .update({'isDelivered': true});
        context.pop();
        Fluttertoast.showToast(
            gravity: ToastGravity.CENTER, msg: 'OTP Verified Successfully');
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            title: 'Order Delivered Successfully 🎉🔥',
            btnOkOnPress: () {
              context.pop();
            }).show();
      } else {
        Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: 'Wrong OTP');
      }
    }
  }
}
