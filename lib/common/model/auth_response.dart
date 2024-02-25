import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';

class AuthResponse{
  final User? user;
  final String? error;

  AuthResponse({this.user, this.error});
}