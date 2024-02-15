import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:geocoding/geocoding.dart';

final paymentOrderDetailController = ChangeNotifierProvider((ref) => PaymentOrderDetailController());

class PaymentOrderDetailController extends ChangeNotifier{


  bool isLoading = false;


  late Placemark placeMark;
  getUserAddress(UserModel user)async{
    isLoading = true;
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(user.latLong!.longitude!, user.latLong!.longitude!);
    if (placeMarks.isNotEmpty) {
       placeMark = placeMarks.first;
       isLoading = false;
    }
    isLoading = false;
    notifyListeners();
  }
}