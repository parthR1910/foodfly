import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_fly/framework/service/fire_base_singleton.dart';
import 'package:path/path.dart';
import 'package:food_fly/ui/utils/widgets/helper.dart';

class StorageService {
  StorageService._private();

  static StorageService service = StorageService._private();


  Future<String> storeUserProfile(BuildContext context, File file, String filename) async {
    try {
      final baseName = basename(file.path);
      final imgUrl = FirebaseSingleTon.firebaseSingleTon.firebaseStorage.ref("UserProfile/$baseName");
      await imgUrl.putFile(file);
      return imgUrl.getDownloadURL();
    } on FirebaseAuthException catch (e) {
      return showSnackBar(context: context, error: e.message.toString());
    }
  }

  Future<String> upLoadFoodImage(File file) async {
    try {
      final baseName = basename(file.path);
      final imgRef = FirebaseSingleTon.firebaseSingleTon.firebaseStorage
          .ref('foods/$baseName');
      await imgRef.putFile(file);
      return imgRef.getDownloadURL();
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message.toString());
    }
  }
}
