import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dashboardControllerProvider = ChangeNotifierProvider<DashboardController>((ref) {
  return DashboardController();
});

class DashboardController extends ChangeNotifier{
  int index  = 0;

  setIndex(int i){
    index=i;
    notifyListeners();
  }
}

