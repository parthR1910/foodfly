import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_fly/framework/model/user_model.dart';
import 'auth_service.dart';




class FireStoreService{


  FireStoreService._private();
  static FireStoreService  fireStoreService = FireStoreService._private();

  final fireStore = FirebaseFirestore.instance;




  Future<void> addUserToFireStore(UserModel user)async{
      await fireStore.collection("User").doc(user.uid).set(
        user.toJson()
      );
  }


 Future<void> updateFireStore({required LatLng latLong, required String phone}) async {
   final uid = AuthService.authService.auth.currentUser!.uid;
  await fireStore.collection('User').doc(uid).update(
      {
       "latLong": latLong.toJson(),
       "phone": phone
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

}