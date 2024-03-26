import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';

import 'food_model.dart';

class OrderDetailModel{
  FoodDataModel foodDataModel;
  UserModel userModel;
  OrderModel orderModel;

  OrderDetailModel(this.foodDataModel,this.userModel,this.orderModel);
}