import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_fly/framework/model/user_model.dart';

import 'auth_service.dart';




class FireStoreService{


  FireStoreService._private();
  static FireStoreService  fireStoreService = FireStoreService._private();

  final fireStore = FirebaseFirestore.instance;
  final uid = AuthService.authService.auth.currentUser!.uid;



  Future<void> addUserToFireStore(UserModel user)async{
      await fireStore.collection("User").doc(user.uid).set(
        user.toJson()
      );
  }


 Future<void> updateFireStore({required String currentLocation, required String phone}) async {
  await fireStore.collection('User').doc(uid).update(
      {
       "CurrentLocation": currentLocation,
       "Phone": phone
      }
    );
  }



 Stream<void> readDataFireStore(UserModel user) {
    final myUser =
     fireStore.collection("User").doc(uid).snapshots().map((snapshot) => UserModel.fromJson(snapshot.data()!));
    return myUser;
  }

}