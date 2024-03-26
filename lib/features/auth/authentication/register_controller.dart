import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/helper/ui_helper.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/local_db.dart';
import 'package:food_fly_delivery_partner/common/utils/services/storage_service.dart';
import 'package:food_fly_delivery_partner/features/auth/address/mobile/address.dart';
import 'package:file_picker/file_picker.dart';

final registerController =
    ChangeNotifierProvider((ref) => RegisterController());

class RegisterController extends ChangeNotifier {
  final GlobalKey<FormState> registerKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool loading = false;
  bool isPassNotShow = true;

  updatesIsPassNotShow() {
    isPassNotShow = !isPassNotShow;
    notifyListeners();
  }

  signUpWithEmailAndPassword(BuildContext context) async {
    if (selectedFile == null) {
      return showSnackBar(context: context, error: 'Please Select Your Image');
    }
    loading = true;
    notifyListeners();
    final response = await AuthService.authService.signUpWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (response.user != null) {
      final imgUrl = await StorageService.service
          .storeUserProfile(context, selectedFile!, fileName!);

      final user = UserModel(
          uid: response.user!.uid,
          email: emailController.text,
          name: nameController.text,
          fcmToken: await FirebaseMessaging.instance.getToken(),
          profileImage: imgUrl,
          type: 'Delivery Boy');
      FireStoreService.fireStoreService.addUserToFireStore(user);
      selectedFile = null;
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Address(),
            ));
      }
      loading = false;
    } else {
      loading = false;
      if (context.mounted) {
        showSnackBar(context: context, error: response.error!);
      }
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
      fileName = result.files.single.name;
      selectedFile = File(result.files.single.path!);
      notifyListeners();
    } else {
      if (context.mounted) {
        showSnackBar(
            context: context, error: "You didn't select any of the picture");
      }
    }
    notifyListeners();
  }

  clearForm() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    notifyListeners();
  }
}
