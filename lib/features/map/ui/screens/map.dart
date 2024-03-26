import 'dart:async';

import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/features/home/controller/home_controller.dart';
import 'package:food_fly_delivery_partner/features/home/controller/order_detail_controller.dart';
import 'package:food_fly_delivery_partner/features/map/controller/map_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/map_style_icon.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({this.latLong, super.key});
  final LatLng? latLong;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    ref.read(mapControllerProvider).init(widget.latLong,widget.latLong!=null,context);
    if(widget.latLong!=null){
    // ref.read(mapControllerProvider).goForOrder(LatLng(widget.latLong!.latitude!, widget.latLong!.longitude!));
    }
  }
  @override
  void dispose() {
    ref.read(mapControllerProvider).markers ={};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeWatch = ref.watch(homeControllerProvider);
    final mapWatch = ref.watch(mapControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
          GoogleMap(
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          mapType: mapWatch.mapType,
          compassEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: mapWatch.initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          // polylines: mapWatch.polyLines,
          markers: mapWatch.markers,
        ),

           /* StreamBuilder<List<OrderModel>>(
                stream:homeWatch.getOrders(context) ,
                builder: (context, snapshot) {
                  // List<OrderDetailModel> orderDetailModel = [];
                  // adders(OrderModel order){
                  //  final orderDetailStream =ref
                  //       .read(orderDetailControllerProvider)
                  //       .orderDetailStream(order.userId, order.foodId,order.id).listen((event) {
                  //   });
                  //  orderDetailStream.onData((data) {
                  //    orderDetailModel.add(data);
                  //  });
                  // }
                  // snapshot.data?.forEach(adders);

                  return
                }),*/
            Positioned(top: 50.h, right: 20.w, child: const MapStyleIcon())
          ],
        ),
      ),
    );
  }

}
