
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/ui/utils/widgets/helper.dart';
import 'package:food_fly/framework/service/auth_service.dart';
import '../../../ui/auth/address/mobile/address.dart';
import '../../../ui/utils/constant/app_const_list.dart';
import '../../../ui/utils/theme/theme.dart';
import '../../service/shared_pref_services.dart';
import '../../service/storage_service.dart';

final registerController = ChangeNotifierProvider((ref) => RegisterController());

class RegisterController extends ChangeNotifier{
  final GlobalKey<FormState> registerKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool loading = false;
  bool isPassNotShow = true;


  updatesIsPassNotShow(){
    isPassNotShow = !isPassNotShow;
    notifyListeners();
  }



  signUpWithEmailAndPassword(BuildContext context)async{
    loading = true;
    notifyListeners();
    final response = await AuthService.authService.signUpWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    if(response.user != null){
       // ignore: use_build_context_synchronously
      final imgUrl = await StorageService.service.storeUserProfile(context, selectedFile!,fileName!);
      final user = UserModel(uid: response.user!.uid, email: emailController.text,name: nameController.text,profileImage: imgUrl);
      FireStoreService.fireStoreService.addUserToFireStore(user);
      selectedFile = null;
      if(context.mounted){
        SharedPrefServices.services.setBool(isAdminKey, false);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Address(),
            ));
      }
      loading=false;
    }else{
      loading=false;
      if(context.mounted){
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
            context: context, error: "you didn't select any of the picture");
      }
    }
    notifyListeners();
  }

  clearForm(){
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    notifyListeners();
  }
}