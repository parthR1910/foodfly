import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_assets.dart';
import 'package:food_fly_delivery_partner/features/map/controller/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStyleIcon extends ConsumerStatefulWidget {
  const MapStyleIcon({super.key});

  @override
  ConsumerState<MapStyleIcon> createState() => _MapStyleIconState();
}

class _MapStyleIconState extends ConsumerState<MapStyleIcon> {
  late OverlayPortalController overlayPortalController;
  @override
  void initState() {
    super.initState();
    overlayPortalController = OverlayPortalController();
  }
  // GlobalKey iconKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final mapWatch = ref.watch(mapControllerProvider);
    // final RenderBox button =
    // iconKey.currentContext!.findRenderObject() as RenderBox;
    // final Offset buttonPosition = button.localToGlobal(Offset.zero);
    return OverlayPortal(
        controller: overlayPortalController,
        overlayChildBuilder: (context) {
          return SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: GestureDetector(
                        onTap: (){
                          overlayPortalController.hide();
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top:80.h,
                    right: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton.filledTonal(onPressed: (){
                          overlayPortalController.hide();
                        }, icon: const Icon(Icons.close)),
                        const SizedBox(height: 20),
            
                        InkWell(
                          onTap: (){
                            mapWatch.mapType=MapType.normal;
                            mapWatch.notifyListeners();
                            overlayPortalController.hide();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5.h),
                                height: 50.h,
                                width: 50.w,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage(AppAssets.normalMapImage),fit:BoxFit.fill)
                                ),
                              ),
                              Text('Normal',style: TextStyle(fontSize: 13.sp,color: Colors.white,fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 80)).moveY(delay: const Duration(milliseconds: 0)),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: (){
                            mapWatch.mapType=MapType.satellite;
                            mapWatch.notifyListeners();
                            overlayPortalController.hide();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5.h),
                                height: 50.h,
                                width: 50.w,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage(AppAssets.satelliteImage),fit:BoxFit.fill)
                                ),
                              ).animate().fadeIn(delay: const Duration(milliseconds: 100)).moveY(delay: const Duration(milliseconds: 100)),

                              Text('Satellite',style: TextStyle(fontSize: 13.sp,color: Colors.white,fontWeight: FontWeight.w500),)

                            ],
                          ),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 80)).moveY(delay: const Duration(milliseconds: 0)),
            
                      ],
                    ),)
                // Positioned(
                //     top: 120.h,
                //     right: 20.w,
                //     child: ),
              ],
            ),
          );
        },
        child: IconButton.filledTonal(
            // key: iconKey,
            onPressed: (){
          overlayPortalController.show();
        }, icon: const Icon(Icons.layers_outlined)));
  }
}
