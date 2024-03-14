import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/model/user_orders/user_orders_model.dart';
import 'package:food_fly/framework/service/auth_service.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final paymentOrderDetailController =
    ChangeNotifierProvider((ref) => PaymentOrderDetailController());

class PaymentOrderDetailController extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingOverlay = false;

  Placemark placeMark = Placemark();
  String location = "";

  getUserAddress(UserModel user) async {
    isLoading = true;
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        user.latLong!.latitude!, user.latLong!.longitude!);
    if (placeMarks.isNotEmpty) {
      placeMark = placeMarks.first;
      location =
          '${placeMark.name}, ${placeMark.street},\n${placeMark.subLocality}, ${placeMark.administrativeArea}, \ncode: ${placeMark.postalCode}    City: ${placeMark.locality}';
      isLoading = false;
    }
    isLoading = false;
    notifyListeners();
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(now);
  }

  Future postUserFoodOrder({required int quantity, required String foodId}) async {
    isLoadingOverlay = true;
    Uuid uuid = const Uuid();
    String uniqueId = uuid.v4();
    final userId = AuthService.authService.auth.currentUser!.uid;
    final UserOrdersModel userOrdersModel = UserOrdersModel(
        quantity: quantity,
        foodId: foodId,
        paidOrNot: false,
        uOrderId: uniqueId,
        userId: userId,
        isDelivered: false,
        dateTime:getCurrentDateTime(),
    );
    await FireStoreService.fireStoreService
        .postFoodToFireStore(userOrdersModel);
    isLoadingOverlay = false;
  }
}
