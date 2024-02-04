import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/framework/model/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:food_fly/framework/service/fire_store_service.dart';

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
        loading = false;
        fullAddress = "${addressController.text}, ${cityController.text}, ${postalCodeController.text}";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future updateDataToFireStore() async {
    if(lat==null)return;
    final latLong = LatLng(latitude: lat,longitude: long);
    await FireStoreService.fireStoreService.updateFireStore(
        latLong: latLong, phone: "$countryCode${phoneController.text}");
  }

  clearForm(){
    phoneController.clear();
    addressController.clear();
    postalCodeController.clear();
    cityController.clear();
  }
}
