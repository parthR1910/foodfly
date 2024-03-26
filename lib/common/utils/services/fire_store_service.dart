import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_fly_delivery_partner/common/model/food_model.dart';
import 'package:food_fly_delivery_partner/common/model/notification_model.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'auth_service.dart';

class FireStoreService {
  FireStoreService._private();
  static FireStoreService fireStoreService = FireStoreService._private();

  final fireStore = FirebaseFirestore.instance;

  Future<void> addUserToFireStore(UserModel user) async {
    await fireStore.collection("User").doc(user.uid).set(user.toJson());
  }

  Stream<List<NotificationDataModel>> getNotificationsFireStore() {
    final notifications = fireStore.collection("Notifications").snapshots().map(
        (event) => event.docs
            .map((e) => NotificationDataModel.fromJson(e.data()))
            .toList());
    return notifications;
  }

  Future<void> updateFireStore(
      {required LatLong latLong,
      required String phone,
      required String address}) async {
    final uid = AuthService.authService.auth.currentUser!.uid;
    await fireStore.collection('User').doc(uid).update(
        {"latLong": latLong.toJson(), "phone": phone, "address": address});
  }

  Future<void> updateUserLocation(LatLong latLong) async {
    final uid = AuthService.authService.auth.currentUser!.uid;
    await fireStore.collection('User').doc(uid).update({
      "latLong": latLong.toJson(),
    });
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

  Stream<FoodDataModel> getFoodFromId(String foodId) {
    final foodModel =
        fireStore.collection("Foods").doc(foodId).snapshots().map((snapshot) {
      return FoodDataModel.fromJson(snapshot.data()!);
    });
    return foodModel;
  }

  Future<FoodDataModel> getFoodFromIdFuture(String foodId) async {
    final foodModel = await fireStore.collection("Foods").doc(foodId).get();
    return FoodDataModel.fromJson(foodModel.data()!);
  }

  Stream<UserModel> getUserFromUserId(String uid) {
    final myUser =
        fireStore.collection("User").doc(uid).snapshots().map((snapshot) {
      return UserModel.fromJson(snapshot.data()!);
    });
    return myUser;
  }

  Future<UserModel> getUserFromUserIdFuture(String uid) async {
    final myUser = await fireStore.collection("User").doc(uid).get();
    return UserModel.fromJson(myUser.data()!);
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
}
