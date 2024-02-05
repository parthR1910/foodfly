import 'package:food_fly/framework/model/user/user_model.dart';

class AuthResponse{
  final UserModel? user;
  final String? error;

  AuthResponse({this.user, this.error});
}