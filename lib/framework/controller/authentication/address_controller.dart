import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/ui/utils/theme/debug_print.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';

import '../../../ui/utils/constant/app_const_list.dart';
import '../../service/auth_service.dart';
import '../../service/hive_service/box_service.dart';

final addressController = ChangeNotifierProvider((ref) => AddressController());

class AddressController extends ChangeNotifier {
  final GlobalKey<FormState> addressKey = GlobalKey();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final String countryCode = "+91";

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
        addressController.text =
            '${placeMark.name}, ${placeMark.street}, ${placeMark.subLocality}, ${placeMark.country}';
        postalCodeController.text = placeMark.postalCode ?? '';
        cityController.text = '${placeMark.administrativeArea}';
        notifyListeners();
        loading = false;
        fullAddress = "${addressController.text} ${cityController.text} ${postalCodeController.text}";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  String? fcmToken;
  getFcmToken()async{
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      Future.error("FCM Token error $e");
    }
  }

  Future updateDataToFireStore() async {
    loading = true;
    if(fcmToken!=null){
      if(lat==null){
        loading = false;
        notifyListeners();
      }
      final latLong = LatLng(latitude: lat,longitude: long);
      await FireStoreService.fireStoreService.updateFireStore(
          latLong: latLong, phone: "$countryCode${phoneController.text}",fcmToken: fcmToken!,address: fullAddress);
      final uid = AuthService.authService.auth.currentUser!.uid;
      final userModel = await FireStoreService.fireStoreService.fireStore.collection("User").doc(uid).get().then((value) => UserModel.fromJson(value.data()!));
      BoxService.boxService.addUserDetailToHive(userModelDetailKey, userModel);
      loading = false;
      fcmToken=null;
    }else{
      loading = false;
      fcmToken=null;
      kPrint("FCM Token Not found");
    }
    notifyListeners();
  }

  clearForm(){
    phoneController.clear();
    addressController.clear();
    postalCodeController.clear();
    cityController.clear();
    fcmToken=null;
  }
}
