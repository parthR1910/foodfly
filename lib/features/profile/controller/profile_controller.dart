import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_const.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_base_singleton.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/local_db.dart';
import 'package:food_fly_delivery_partner/common/utils/services/storage_service.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/address_controller.dart';
import 'package:food_fly_delivery_partner/features/dashboard/controller/dashboard_controller.dart';
import 'package:food_fly_delivery_partner/features/profile/repository/profile_repository.dart';
import 'package:image_picker/image_picker.dart';

final profileControllerProvider =
    ChangeNotifierProvider<ProfileController>((ref) {
  return ProfileController(ref);
});

class ProfileController extends ChangeNotifier {
  ProfileController(this.ref);
  Ref ref;
  GlobalKey<FormState> profilekey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String selectedImgPath = '';
  bool isLoading = false;

  Stream<UserModel> getProfileDetailsStream(BuildContext context) {
    return FireStoreService.fireStoreService.getCUserDataFireStore();
  }

  init(UserModel userModel) {
    nameController.text = userModel.name ?? '';
    numberController.text =
        userModel.phone?.substring(3, userModel.phone?.length) ?? '';
    addressController.text = userModel.address ?? '';
  }

  clearData() {
    nameController.text = '';
    numberController.text = '';
    addressController.text = '';
    selectedImgPath = '';
    isLoading = false;
    notifyListeners();
  }

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImgPath = image.path;
      notifyListeners();
    }
  }

  updateProfile(String userId, BuildContext context) async {
    if (profilekey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      String imgUrl = '';

      if (selectedImgPath.isNotEmpty) {
        imgUrl = await StorageService.service.storeUserProfile(
            context, File(selectedImgPath), nameController.text);
      }
      await FirebaseSingleTon.firebaseSingleTon.fireStore
          .collection('User')
          .doc(userId)
          .update({
        if (selectedImgPath.isNotEmpty) 'profileImage': imgUrl,
        'name': nameController.text,
        'address': addressController.text,
        'phone': numberController.text
      });
      Fluttertoast.showToast(
          gravity: ToastGravity.CENTER, msg: 'Profile updated successfully');
      context.pop();
      isLoading = false;
      notifyListeners();
    }
  }

  showLogoutBottomSheet(BuildContext context) {
    showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      context: context,
      transitionDuration: 200.milliseconds,
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    AuthService.authService.signOut(false);

                    context.pushAndRemoveUntilNamed(AppRoutes.login);
                    ref.read(dashboardControllerProvider).setIndex(0);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
            title: Text('Are Sure to Logut',
                style: TextStyle(
                  fontSize: 15.sp,
                )));
      },
    );
  }
}
