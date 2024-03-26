import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';

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
          desiredAccuracy: LocationAccuracy.bestForNavigation);
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
        loading = false;
        fullAddress =
            "${addressController.text}, ${cityController.text}, ${postalCodeController.text}";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future updateDataToFireStore() async {
    loading = true;
    notifyListeners();
    if (lat == null) {
      loading = false;
      notifyListeners();
    }
    final latLong = LatLong(latitude: lat, longitude: long);
    await FireStoreService.fireStoreService.updateFireStore(
        latLong: latLong,
        phone: "$countryCode${phoneController.text}",
        address: fullAddress);
    final uid = AuthService.authService.auth.currentUser!.uid;
    final userModel = await FireStoreService.fireStoreService.fireStore
        .collection("User")
        .doc(uid)
        .get()
        .then((value) => UserModel.fromJson(value.data()!));
    loading = false;
    notifyListeners();
  }

  clearForm() {
    phoneController.clear();
    addressController.clear();
    postalCodeController.clear();
    cityController.clear();
  }
}
