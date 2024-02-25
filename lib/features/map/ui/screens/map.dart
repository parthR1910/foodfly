import 'package:flutter/material.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_assets.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

class MapScreen extends StatelessWidget{
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:InteractiveViewer(
        maxScale: 500,
        child: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.dummyMapImage),fit: BoxFit.cover)),
        ),
      )
    );
  }
}