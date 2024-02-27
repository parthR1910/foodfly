import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/service/hive_service/box_service.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/theme/debug_print.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../service/auth_service.dart';
import '../../service/fire_store_service.dart';

final homeAddressController = ChangeNotifierProvider((ref) => HomeAddressController());


class HomeAddressController extends ChangeNotifier{

  final GlobalKey<FormState> addressKey = GlobalKey();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();


  bool loading = false;
  String fullAddress = '';
  double? lat;
  double? long;

  getCurrentLocation() async {
    loading = true;
    notifyListeners();
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      loading = false;
      await Geolocator.requestPermission();
      notifyListeners();
    } else {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double longitude = position.longitude;
      double latitude = position.latitude;
      lat = position.latitude;
      long = position.longitude;
      notifyListeners();
      List<Placemark> placeMarks =
      await placemarkFromCoordinates(latitude, longitude);
      if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks.first;
        addressController.text = '${placeMark.street} ${placeMark.subLocality} ${placeMark.subAdministrativeArea}';
        postalCodeController.text = placeMark.postalCode ?? '';
        cityController.text = '${placeMark.locality}';
        stateController.text = '${placeMark.administrativeArea}';
        notifyListeners();
        loading = false;
        fullAddress = "${addressController.text}, ${cityController.text}, ${postalCodeController.text}";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  addAddressToField()async{
    loading = true;
    notifyListeners();
    final user = BoxService.boxService.userModelBox.get(userModelDetailKey);
    if(user !=null){
      List<Placemark> placeMarks =
      await placemarkFromCoordinates(user.latLong!.latitude!, user.latLong!.longitude!);
      if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks.first;
        addressController.text = '${placeMark.street} ${placeMark.subLocality} ${placeMark.subAdministrativeArea}';
        postalCodeController.text = placeMark.postalCode ?? '';
        cityController.text = '${placeMark.locality}';
        stateController.text = '${placeMark.administrativeArea}';
        loading = false;
        notifyListeners();
      }
    }else{
      loading = false;
      notifyListeners();
    }
  }

  changeAddress()async {
    loading = true;
    notifyListeners();
    try{
      final value = await locationFromAddress("${addressController.text}, ${cityController.text}, ${stateController.text}, ${postalCodeController.text}");
      List<Placemark> placeMarks =
      await placemarkFromCoordinates(value[0].latitude, value[0].longitude);
      Placemark placeMark = placeMarks.first;
      addressController.text = '${placeMark.street} ${placeMark.subLocality} ${placeMark.subAdministrativeArea}';
      postalCodeController.text = placeMark.postalCode ?? '';
      cityController.text = '${placeMark.locality}';
      stateController.text = '${placeMark.administrativeArea}';
      fullAddress = "${addressController.text}, ${cityController.text}, ${postalCodeController.text}";
      notifyListeners();
      final uid = AuthService.authService.auth.currentUser!.uid;
      LatLng latLng= LatLng(latitude:value[0].latitude ,longitude: value[0].longitude);
      await FireStoreService.fireStoreService.fireStore.collection('User').doc(uid).update(
          {
            "latLong": latLng.toJson(),
          }
      );
      final userModel = await FireStoreService.fireStoreService.fireStore.collection("User").doc(uid).get().then((value) => UserModel.fromJson(value.data()!));
      BoxService.boxService.addUserDetailToHive(userModelDetailKey, userModel);
      notifyListeners();
      loading = false;
    }catch (e){
      loading = false;
      Future.error(e.toString());
    }
    notifyListeners();
  }
}