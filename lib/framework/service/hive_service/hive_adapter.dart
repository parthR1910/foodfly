import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:hive/hive.dart';


void registerHiveAdapters() {
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(LatLngAdapter());
}