import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_fly/framework/model/food_cart_model/food_cart_model.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/model/user_orders/user_orders_model.dart';
import 'package:food_fly/framework/service/fire_base_singleton.dart';
import 'auth_service.dart';


class FireStoreService {
  FireStoreService._private();

  static FireStoreService fireStoreService = FireStoreService._private();

  final fireStore = FirebaseFirestore.instance;

  Future<void> addUserToFireStore(UserModel user) async {
    await fireStore.collection("User").doc(user.uid).set(
        user.toJson()
    );
  }


  Future<void> updateFireStore(
      {required LatLng latLong, required String phone, required String fcmToken, required String address}) async {
    final uid = AuthService.authService.auth.currentUser!.uid;
    await fireStore.collection('User').doc(uid).update(
        {
          "latLong": latLong.toJson(),
          "phone": phone,
          "fcmToken": fcmToken,
          "address": address
        }
    );
  }


  Stream<UserModel> getCUserDataFireStore() {
    final uid = AuthService.authService.auth.currentUser!.uid;
    // print("user id $uid");
    final myUser =
    fireStore.collection("User").doc(uid).snapshots().map((snapshot) {
      // print(snapshot.data()!);
      return UserModel.fromJson(snapshot.data()!);
    });
    // print("user name ${myUser.first}");
    return myUser;
  }


  // Future<UserModel> getCUserDataFireStore() {
  //   final uid = AuthService.authService.auth.currentUser!.uid;
  //   final myUser =
  //   // fireStore.collection("User").doc(uid).snapshots().map((snapshot) {
  //   //   return UserModel.fromJson(snapshot.data()!);
  //   // });
  //   fireStore.collection("User").doc(uid).get().then((value) => UserModel.fromJson(value.data()!));
  //   return myUser;
  // }


  ///-------------------food  admin-----------///
  Future<void> addFoodToFirebase(FoodDataModel newsTable) async {
    await FirebaseSingleTon.firebaseSingleTon.fireStore
        .collection('Foods')
        .doc(newsTable.foodId)
        .set(newsTable.toJson());
  }

  Future<void> updateFoodToFirebase(FoodDataModel newsTable) async {
    await FirebaseSingleTon.firebaseSingleTon.fireStore
        .collection('Foods')
        .doc(newsTable.foodId).update(
        {
          "foodId": newsTable.foodId,
          "categoryId": newsTable.categoryId,
          "description": newsTable.description,
          "image": newsTable.image,
          "price": newsTable.price,
          "tax": newsTable.tax,
          "offPrice": newsTable.offPrice,
          "name": newsTable.name,
        }
    );
  }


  Stream<List<FoodDataModel>> getFoodDataFireStore() {
    final foodData = fireStore.collection("Foods").snapshots().map((event) =>
        event.docs.map((e) => FoodDataModel.fromJson(e.data())).toList());
    return foodData;
  }

  Future<void> deleteFoodToFirebase({required String id}) async {
    await FirebaseSingleTon.firebaseSingleTon.fireStore
        .collection('Foods')
        .doc(id)
        .delete();
  }

  ///-------------------food  admin-----------///


  ///-------------------food Orders-----------///

  Future<void> postUserFoodOrderToFireStore(
      UserOrdersModel userOrdersModel) async {
    await fireStoreService.fireStore.collection("UserOrders").doc(
        userOrdersModel.uOrderId).set(
        userOrdersModel.toJson()
    );
  }

  ///-------------------food Orders-----------///

  Future<void> postUserFoodOrderCartToFireStore(
      FoodCartModel foodCartModel) async {
    await fireStoreService.fireStore.collection("UserCartOrders").doc(
        foodCartModel.uOrderId).set(
        foodCartModel.toJson()
    );
  }

  Stream<List<FoodCartModel>> getUserFoodCartOrdersFireStore() {
    final foodData = fireStore.collection("UserCartOrders").snapshots().map((
        event) =>
        event.docs.map((e) => FoodCartModel.fromJson(e.data())).toList());
    return foodData;
  }

///------------------------food to cart ----------------------///

}