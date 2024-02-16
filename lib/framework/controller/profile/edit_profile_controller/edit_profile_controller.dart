import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/service/auth_service.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/framework/service/hive_service/box_service.dart';
import 'package:food_fly/framework/service/storage_service.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../ui/utils/widgets/helper.dart';

final editProfileController = ChangeNotifierProvider((ref) => EditProfileController());

class EditProfileController extends ChangeNotifier{


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();


  String profileImgUrl ="";

  bool isLoading = false;


  addDataToTextField()async{
    final user = BoxService.boxService.userModelBox.get(userModelDetailKey)!;
    nameController.text = user.name!;
    emailController.text = user.email!;
    profileImgUrl = user.profileImage!;
    final String number = user.phone!.substring(3);
    phoneController.text = number;

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(user.latLong!.longitude!, user.latLong!.longitude!);
    if (placeMarks.isNotEmpty) {
      Placemark placeMark = placeMarks.first;
      addressController.text =
      '${placeMark.name}, ${placeMark.street}, ${placeMark.subLocality}, ${placeMark.country}';}
    notifyListeners();
  }


  bool isUpdate = false;

  checkIsUpdateOrNot(){
    final user = BoxService.boxService.userModelBox.get(userModelDetailKey)!;
    if(user.name != nameController.text || user.email !=emailController.text || user.phone!.substring(3)!=phoneController.text || selectedFile != null ){
      isUpdate = true;
    }else{
      isUpdate = false;
    }
    notifyListeners();
  }



  File? selectedFile;
  String? fileName;

  pickImageFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['jpg', 'png'],
        allowMultiple: true,
        type: FileType.custom);
    if (result != null) {
      fileName = result.files.
        single.name;
      selectedFile = File(result.files.single.path!);
      isUpdate = true;
      notifyListeners();
    } else {
      isUpdate = false;
      if (context.mounted) {
        showSnackBar(
            context: context, error: "you didn't select any of the picture");
      }
    }
    notifyListeners();
  }


  Future updateUserDataOnFireStore(BuildContext context)async{
   try{
     isLoading = true;
     notifyListeners();
     final user = BoxService.boxService.userModelBox.get(userModelDetailKey)!;
     String profileImage = user.profileImage!;
     if(selectedFile != null) {
       final userImage = await StorageService.service.upLoadFoodImage(selectedFile!);
       profileImage = userImage;
     }
     final userDataModel = UserModel(name: nameController.text,phone: "+91${phoneController.text}",profileImage:profileImage , latLong: user.latLong,email: user.email);
     await BoxService.boxService.addUserDetailToHive(userModelDetailKey,userDataModel );
     final uid = AuthService.authService.auth.currentUser!.uid;
     FireStoreService.fireStoreService.fireStore.collection("User").doc(uid).update({
       "name":nameController.text,
       "phone": "+91${phoneController.text}",
       "profileImage": profileImage,
     });
     Navigator.pop(context);
     isLoading = false;
     notifyListeners();
     clearData();
   }catch (e){
     Future.error("-----update profile$e");
     isLoading = false;
   }
   notifyListeners();
  }
  
  
  
  
  clearData(){
    selectedFile = null;
    isUpdate = false;
    nameController.clear();
    emailController.clear();
    addressController.clear();
    phoneController.clear();
    profileImgUrl ="";
    notifyListeners();
  }
}