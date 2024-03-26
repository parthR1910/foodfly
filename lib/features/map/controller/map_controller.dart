import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_assets.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_colors.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_const.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/helper/debug_print.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
import 'package:food_fly_delivery_partner/features/home/controller/order_detail_controller.dart';
import 'package:food_fly_delivery_partner/features/home/ui/screens/order_detail.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../home/controller/home_controller.dart';

final mapControllerProvider = ChangeNotifierProvider<MapController>((ref) {
  return MapController(ref);
});

class MapController extends ChangeNotifier {
  MapController(this.ref);
  Ref ref;
  double? lat;
  double? long;
  List<OrderMapModel> orderDetailModel = [];
  BitmapDescriptor bitmapDescriptor = BitmapDescriptor.defaultMarker;
  MapType mapType = MapType.normal;
  List<LatLng> polyLineCoordinates = [];
  Set<Polyline> polyLines = {};
  Set<Marker> markers ={};
  late CameraPosition initialCameraPosition;

  init(LatLng? orderLatLng,bool isFromOrder,BuildContext context){
    print('orderLatLng');
    print(isFromOrder);
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), AppAssets.orderUserIcon)
        .then((value) {
      bitmapDescriptor = value;
    });
    initialCameraPosition = CameraPosition(
      target:
      LatLng(orderLatLng?.latitude ?? 23.0225, orderLatLng?.longitude ?? 72.5714),
      zoom: orderLatLng != null ? 14.4746 : 11.6,
    );
   getOrderMarkers(isFromOrder,context);
  }

/*  Stream<List<OrderMapModel>> getOrders(BuildContext context) async* {
    print('getOrders');

    final homeController = ref.read(homeControllerProvider);
    final orders = await homeController.getOrders(context).first; // Get the initial list of orders

    for (var order in orders.where((element) => !element.isDelivered)) {
      final orderDetailWatch = ref.watch(orderDetailControllerProvider);
      final model = await orderDetailWatch.orderDetailFromFuture(
          order.userId, order.foodId, order);
      final mapOrderDetailModel = OrderMapModel(order, model);
      yield orderDetailModel; // Yield the updated list after each iteration
    }
  }*/

  void getOrderMarkers(bool isFromOrder,BuildContext context) {
    ref.read(homeControllerProvider).getOrders().listen((orders) async {
      for (OrderModel order in orders) {
        bool isAvailable = false;
        for (var marker in markers) {
          if(marker.markerId==MarkerId(order.id)){
            isAvailable = true;
          }
        }
        if(!isAvailable && !order.isDelivered){
          final userModel =await  FireStoreService.fireStoreService.getUserFromUserIdFuture(order.userId);
          final foodModel = await FireStoreService.fireStoreService.getFoodFromIdFuture(order.foodId);
          print('userModel.latLong!.latitude!');
          print(userModel.latLong!.latitude!);
          print(userModel.latLong!.longitude!);
          markers.add(Marker(
              onTap: () {
                if (!isFromOrder) {
                  context.push(OrderDetail(orderDetailModel: OrderDetailModel(foodModel, userModel, order)));
                }
              },
              infoWindow:  InfoWindow(title: userModel.name),
              markerId: MarkerId(order.id),
              icon: bitmapDescriptor,
              position: LatLng(
                  userModel.latLong!.latitude!, userModel.latLong!.longitude!)));
          notifyListeners();

        }
      }
    });
    /*  print('getOrderMarkers');
      print(orders.length);
    return {
      ...orders.map((e) {
        return Marker(
            onTap: () {
              if (!isFromOrder) {
                context.push(OrderDetail(orderDetailModel: e));
              }
            },
            infoWindow:  InfoWindow(title: e.userModel.name),
            markerId: MarkerId(e.orderModel.id ?? ''),
            icon: bitmapDescriptor,
            position: LatLng(
                e.userModel.latLong!.latitude!, e.userModel.latLong!.longitude!));
      }).toList(),
      if(lat!=null)
      Marker(markerId: const MarkerId('MyLocation'),position: LatLng(lat!, long!),icon: BitmapDescriptor.defaultMarker,infoWindow: const InfoWindow(title: 'Me'))
    };*/
  }
  goForOrder(LatLng destination){
    Geolocator.getCurrentPosition().then((event) {
      getPolyPoints(LatLng(event.latitude,event.longitude), destination);
    });
    Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation,)).listen((event) {
      lat = event.latitude;
      long = event.longitude;
      getPolyPoints(LatLng(event.latitude,event.longitude), destination);
    });
  }


  getPolyPoints( LatLng origin,LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapApiKey,
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      kprint(result.errorMessage);
    }
    getPolyLineFromCoordinates();
  }

  getPolyLineFromCoordinates(){
    polyLines.add(Polyline(polylineId: const PolylineId('value'),points: polyLineCoordinates,color: const Color(0xFFEB0029)));
    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
  focusOnCurrentLocation(){
    initialCameraPosition = CameraPosition(target: LatLng(lat!, long!),zoom:14.5);
    notifyListeners();
  }
}

class OrderMapModel {
  OrderDetailModel orderDetailModel;
  OrderModel orderModel;
  OrderMapModel(this.orderModel, this.orderDetailModel);
}
